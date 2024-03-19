//
//  Usuario.swift
//  iecaappadmin
//
//  Created by Omar on 01/03/24.
//

import Foundation


struct Apellido: Identifiable, Codable {
    
    var Id: String
    var Apellido: String
    var Fecha: String
    var IdEmpresa: String
    var Borrado: String?
    
    var id: String {
            return Id
        }
    
//    var fecha: Date? {
//           let dateFormatter = DateFormatter()
//           dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//           return dateFormatter.date(from: Fecha)
//       }
}

