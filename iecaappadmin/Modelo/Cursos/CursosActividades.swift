//
//  CursosActividades.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CursosActividades: Identifiable, Codable {
    
    var Id: String
    var IdEmpresa: String
    var Nombre: String
    var Fecha: String
    var Notas: String
    var Observaciones: String
    var IdCurso: String
    var IdActividad: String
    var Link: String

    var id: String {
        return Id
    }
    
    var fecha: Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Define el formato de la fecha que recibes
           
           return dateFormatter.date(from: Fecha)
       }
    
}
