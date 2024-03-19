//
//  SucursalTipo.swift
//  iecaappadmin
//
//  Created by Omar on 29/02/24.
//

import Foundation


struct SucursalTipo: Identifiable, Codable {
    var Id: String
    var Nombre: String
    var Fecha: String
    var IdEmpresa: String
    var Borrado: Bool
    var Virtual: Bool
    var Notas: String
    
    
    var id: String { // Declaración manual de la propiedad id
            return Id
        }
    
    var fecha: Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Define el formato de la fecha que recibes
           
           return dateFormatter.date(from: Fecha)
       }
}
