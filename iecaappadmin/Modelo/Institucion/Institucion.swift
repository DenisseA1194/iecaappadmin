//
//  Zona.swift
//  iecaappadmin
//
//  Created by Omar on 29/02/24.
//

import Foundation

struct Institucion: Identifiable, Codable, Equatable {
    var Id: String
    var Nombre: String
    var LogoLink: String
    var Fecha: String
    var Status: Bool
    var borrado: Bool?
    var Correo: String
    var Telefono: String
    var Notas: String
    var IdEmpresa: String
    var IdRazonSocial: String
    
    
    
    var id: String {
            return Id
        }
    
    var fecha: Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
           
           return dateFormatter.date(from: Fecha)
       }
}
