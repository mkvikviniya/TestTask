//
//  UnsplashJSONModel.swift
//  TestTask
//
//  Created by Михаил Квиквиния on 14.10.2021.
//

import Foundation

struct UnsplashJSONModel: Decodable {
  //  let id: String
    let alt_description: String?
    let urls: ImageURL
    let likes: Int?
    var likesString: String {
        return String(likes ?? 0)
    }
}

struct ImageURL: Decodable{
    let regular: String
}
