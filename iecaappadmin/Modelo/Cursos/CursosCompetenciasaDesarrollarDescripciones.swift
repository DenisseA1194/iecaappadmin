//
//  CursosCompetenciasaDesarrollarDescripciones.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CursosCompetenciasaDesarrollarDescripciones: Identifiable, Codable {
    
    var Id: String
    var Nombre: String
    var Fecha: Date
    var IdEmpresa: String
    var IdCursosCompetenciasaDesarrollar: String
    var Notas: String
    var Observaciones: String
    
    var id: String {
        return Id
    }
    
}
