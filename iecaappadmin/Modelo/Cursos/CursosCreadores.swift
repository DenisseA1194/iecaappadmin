//
//  CursosCreadores.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CursosCreadores: Identifiable, Codable {
    
    var Id: String
    var IdCurso: String
    var IdCreador: String
    var Notas: String
    var Observaciones: String
    var Version: String
    var LinkDocs: String
    var Fecha: Date
    var IdEmpresa: String
  
    var id: String {
        return Id
    }
    
}
