//
//  Zona.swift
//  iecaappadmin
//
//  Created by Omar on 29/02/24.
//

import Foundation

struct Competencia: Identifiable, Codable {
    
    var Id: String
    var IdEmpresa: String
    var Nombre: String
    var Notas: String
    var Fecha: String
    var Borrado: Bool
    var Observaciones: String
    var id: String {
            return Id
        }
    var Status: Bool
    
    var fecha: Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
           
           return dateFormatter.date(from: Fecha)
       }
}
