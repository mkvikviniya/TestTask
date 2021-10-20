//
//  DateExtension.swift
//  TestTask
//
//  Created by Михаил Квиквиния on 15.10.2021.
//

import Foundation

extension Date {
    
    var dateOfTheDay: String {
        let dateFormatter = DateFormatter.shared
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: self)
    }
       
}

extension DateFormatter {
    static var shared: DateFormatter = {
        return DateFormatter()
    }()

}
