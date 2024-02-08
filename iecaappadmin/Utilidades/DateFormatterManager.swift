//
//  DateFormatterManager.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation

class DateFormatterManager {
    static let shared = DateFormatterManager()
    
    private let dateFormatter: DateFormatter
    
    private init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    }
    
    func format(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
