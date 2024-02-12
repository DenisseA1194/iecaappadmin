//
//  CursosBibliografias.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CursosBiografias: Identifiable, Codable {
    
    var Id: String
    var Nombre: String
    var IdCurso: String
    var IdActividad: String
    var Notas: String
    var Autor: String
    var Observaciones: String
    var Fecha: String
    var IdEmpresa: String
    var Link: String
    var IdTipoBibliografia: String
    
    var fecha: Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Define el formato de la fecha que recibes
           
           return dateFormatter.date(from: Fecha)
       }
    var Borrado: Bool
  
    var id: String {
        return Id
    }
    
    
    
}
