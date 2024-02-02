//
//  CursosCompetenciasaDesarrollar.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CursosCompetenciasaDesarrollar: Identifiable, Codable {
    
    var Id: String
    var Nombre: String
    var Fecha: Date
    var IdEmpresa: String
  
    var id: String {
        return Id
    }
    
}
