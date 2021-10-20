//
//  DetailView.swift
//  TestTask
//
//  Created by Михаил Квиквиния on 15.10.2021.
//

import SwiftUI

struct DetailView: View {
    
    let detailObject: RealmObject
    
    var body: some View{
        VStack{
            GeometryReader{ geo in
                Image(uiImage: UIImage(data: detailObject.image!)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width)
            }.padding(.init(5))
            
            Text("Image has \(detailObject.likes!) likes")
            
            Text(detailObject.alt_description ?? "No image description")
            
            Text("Image downloaded at " + detailObject.downloadDate!.dateOfTheDay)
            
            
        }
    }
    
}
