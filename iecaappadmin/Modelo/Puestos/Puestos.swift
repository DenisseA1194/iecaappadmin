//
//  Usuario.swift
//  iecaappadmin
//
//  Created by Omar on 01/03/24.
//

import Foundation


struct Puesto: Identifiable, Codable {
    
    var Id: String
    var IdEmpresa: String
    var Nombre: String
    var Notas: String
    var Fecha: String
    var borrado: Bool?
    
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

