//
//  CursosEvaluaciones.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CursosEvaluaciones: Identifiable, Codable {
    
    var Id: String
    var Fecha: Date
    var IdEmpresa: String
    var IdCurso: String
    var IdLista: String
    var Status: String
    var Observaciones: String
    var Notas: String
    var Link: String
    var Borrado: Bool
    
    var id: String {
        return Id
    }
    
}
