//
//  CursosDocumentacion.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CursosDocumentacion: Identifiable, Codable {
    
    var Id: String
    var IdCurso: String
    var IdEmpresa: String
    var Nombre: String
    var Fecha: String
    var LinkDocumento: String
    var Notas: String
    var Referencias: String
    
    var fecha: Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Define el formato de la fecha que recibes
           
           return dateFormatter.date(from: Fecha)
       }
  
    var id: String {
        return Id
    }
    
}
