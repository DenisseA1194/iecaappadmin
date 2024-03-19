//
//  Zona.swift
//  iecaappadmin
//
//  Created by Omar on 29/02/24.
//

import Foundation

struct Zona: Identifiable, Codable {
    var Id: String
    var IdEmpresa: String
    var Nombre: String
    var Notas: String
    var Fecha: String
    var borrado: Bool
    
    var id: String {
            return Id
        }
    
    var fecha: Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
           
           return dateFormatter.date(from: Fecha)
       }
}
