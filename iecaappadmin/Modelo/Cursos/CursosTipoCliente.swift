//
//  CursosTipoCliente.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CursosTipoCliente: Identifiable, Codable {
    
    var Id: String
    var IdCurso: String
    var IdTipoCliente: String
    var Observaciones: String
    var Notas: String
    var Status: String
    var Fecha: Date
    var IdEmpresa: String
    var Borrado: Bool
    
    var id: String {
        return Id
    }
    
}
