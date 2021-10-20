//
//  RealmObject.swift
//  TestTask
//
//  Created by Михаил Квиквиния on 14.10.2021.
//

import Foundation
import RealmSwift

@objcMembers class RealmObject: Object, Identifiable{
    dynamic var id: UUID?
    dynamic var image: Data?
    dynamic var alt_description: String?
    dynamic var likes: String?
    dynamic var downloadDate: Date?
}


//struct RealmObject: Identifiable{
//    let id: String
//    let image: Data?
//    let alt_description: String?
//    let likes: Int?
//    let downloadDate: Date?
//}

//extension RealmObject: Equatable {
//    static func == (lhs: RealmObject, rhs: RealmObject) -> Bool {
//        return lhs.id == rhs.id
//    }
//}
