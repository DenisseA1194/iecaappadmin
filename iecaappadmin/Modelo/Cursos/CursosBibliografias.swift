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
    var Fecha: Date
    var IdEmpresa: String
    var Link: String
    var IdTipoBibliografia: String
    var Borrado: Bool
  
    var id: String {
        return Id
    }
    
}
