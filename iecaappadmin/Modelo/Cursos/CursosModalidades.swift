//
//  CursosModalidades.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CursosModalidades: Identifiable, Codable {
    
    var Id: String
    var IdCurso: String
    var IdModalidad: String
    var Notas: String
    var Observaciones: String
    var Fecha: Date
    var IdEmpresa: String
    var Borrado: Bool
    
    var id: String {
        return Id
    }
    
}
