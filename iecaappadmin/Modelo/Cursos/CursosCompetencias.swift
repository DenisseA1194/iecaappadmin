//
//  CursosCompetencias.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CursosCompetencias: Identifiable, Codable {
    
    var Id: String
    var IdEmpresa: String
    var Nombre: String
    var Fecha: Date
    var IdCompetencia: String
    var IdCompetenciaDetalle: String
    var Observaciones: String
    var IdCurso: String
    var Notas: String
    var Borrado: Bool
  
    var id: String {
        return Id
    }
    
}
