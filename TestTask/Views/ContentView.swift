//
//  ContentView.swift
//  TestTask
//
//  Created by Михаил Квиквиния on 14.10.2021.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @ObservedObject var appManager = AppManager()
    
    let realm = try! Realm()
    
    @ObservedResults(RealmObject.self) var realmObjects
    
    var body: some View {
        
        NavigationView{
            VStack {
                
                if appManager.objectsToShow.isEmpty && !realmObjects.isEmpty{
                    ScrollView(.vertical){
                        LazyVStack{
                            ForEach(realmObjects.freeze()){
                                object in
                                
                                NavigationLink(destination: DetailView(detailObject: object)){
                                    ImageCell(image: object.image!, likes: object.likes!)
                                        .onAppear {
                                            if realmObjects.freeze().last?.id == object.id && !appManager.isLoading {
                                                appManager.currentPage += 1
                                                appManager.getImages()
                                            }
                                        }
                                }
                            }
                        }
                    }
                    
                }else if appManager.objectsToShow.isEmpty && realmObjects.isEmpty{
                    Text("Sorry, no internet connection")
                        .padding()
                    Button(action: {
                        appManager.getImages()
                                            }) {
                        Text("Try Again")
                    }
                }else{
                    ScrollView(.vertical){
                        LazyVStack{
                            ForEach(appManager.objectsToShow){
                                object in
                                
                                NavigationLink(destination: DetailView(detailObject: object)){
                                    ImageCell(image: object.image!, likes: object.likes!)
                                        .onAppear {
                                            if self.appManager.objectsToShow.last?.id == object.id && !appManager.isLoading {
                                                appManager.currentPage += 1
                                                appManager.getImages()
                                            }
                                        }
                                }
                            }
                        }
                    }
                }
            }
        }.navigationBarHidden(true)
            .onAppear(){
                appManager.getImages()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
