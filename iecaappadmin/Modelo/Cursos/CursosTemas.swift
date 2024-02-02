//
//  CursosTemas.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CursosTemas: Identifiable, Codable {
    
    var Fecha: Date
    var Id: String
    var IdEmpresa: String
    var Notas: String
    var Observaciones: String
    var IdCurso: String
    var IdTema: String
    var Horas: Int
    
    var id: String {
        return Id
    }
    
}
