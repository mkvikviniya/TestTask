//
//  ImageCell.swift
//  TestTask
//
//  Created by Михаил Квиквиния on 14.10.2021.
//

import SwiftUI

struct ImageCell: View {

let image: Data
let likes: String

var body: some View{
    
    HStack(spacing: 4){
        
        Image(uiImage: UIImage(data: image)!)
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .cornerRadius(15)
            .padding(5)
        
        Text("Image has \(likes) likes")
            .font(.system(size: 15, weight: .bold, design: .serif))
            .frame(width: 200, height: 100, alignment: .center)
        
    }
    
    
}
}
