//
//  CursosMateriales.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CursosMateriales: Identifiable, Codable {
    
    var Id: String
    var Nombre: String
    var IdCurso: String
    var IdMaterial: String
    var Fecha: Date
    var Borrado: Bool
    var Notas: String
    var Observaciones: String
    var IdEmpresa: String
  
    var id: String {
        return Id
    }
    
}
