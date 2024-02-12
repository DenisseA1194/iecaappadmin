//
//  CursosEquipos.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CursosEquipos: Identifiable, Codable {
    
    var Id: String
    var Nombre: String
    var IdCurso: String
    var IdEquipo: String
    var Fecha: Date
    var Link: String
    var Notas: String
    var Observaciones: String
    var IdEmpresa: String
    var Borrado: Bool
  
    var id: String {
        return Id
    }
    
}
