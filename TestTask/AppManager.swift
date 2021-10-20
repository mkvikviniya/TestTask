//
//  AppManager.swift
//  TestTask
//
//  Created by Михаил Квиквиния on 14.10.2021.
//

import Foundation
import RealmSwift

class AppManager: ObservableObject {
        
    let url = "https://api.unsplash.com/photos?client_id=uTR6yRjI4-hOdt3VbEETJ23vK4xI3ATH2b1iVsOWgcc&per_page=15&page="
    
    var currentPage = 1
    
    @Published var objectsToShow = [RealmObject]()
    
    @Published var noNetworkConnection = false
    
    var realmCleared = false
    
    var isLoading = false
        
    func getDataFromUnsplash(completionHandler: @escaping (Result<[UnsplashJSONModel], Error>) -> Void){
       
        if let url = URL(string: "\(url)\(String(currentPage))"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let objects = try decoder.decode([UnsplashJSONModel].self, from: safeData)
                            
                            DispatchQueue.main.async {
                                
                                completionHandler(.success(objects))
                                
                                self.noNetworkConnection = false
                               
                            }
                        } catch {
                            print(error)
                        }
                    }
                }else{
                    print(error)
                    self.noNetworkConnection = true
                    self.isLoading = false
                                }
            }
            task.resume()
        }
    }
    
    func getImages(){
        
       guard !isLoading else {
            return
        }
        isLoading = true
        
        getDataFromUnsplash { result in
            switch result {
            case .success(let objects):
                
                for object in objects {
                    guard let url = URL(string: object.urls.regular) else {return}
                    let task = URLSession.shared.dataTask(with: url){ data, response, error in
                        DispatchQueue.main.async {
                            let fetchedObject = RealmObject()
                            fetchedObject.id = UUID()
                            fetchedObject.image = data
                            fetchedObject.alt_description = object.alt_description ?? "No image description"
                            fetchedObject.likes = object.likesString
                            fetchedObject.downloadDate = Date()
                            
                            self.objectsToShow.append(fetchedObject)
                            
                            
                        
                            
                            let realm = try! Realm()
                            
                            if !self.realmCleared{
                                var objectsToDelete = [RealmObject]()
                                objectsToDelete.append(contentsOf: realm.objects(RealmObject.self))
                                do{
                                    try realm.write({
                                        realm.delete(objectsToDelete)
                                    })
                                    
                                    self.realmCleared = true
                                    
                                }catch{
                                    print("Error clearing realm \(error)")}
                            }
                            
                            do{
                                try realm.write({
                                    realm.add(fetchedObject)
                                })
                            }catch{
                                print("error saving context \(error)")
                            }
                        }
                    }
                    self.noNetworkConnection = false
                    self.isLoading = false
                    task.resume()
                }
            case .failure(let error): print(error)
                self.isLoading = false
                self.noNetworkConnection = true
            }
        }
        
    }
    
    
    
    
}
