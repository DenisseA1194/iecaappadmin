//
//  CatalogoClientesClasificaciones.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CatalogoClientesClasificaciones: Identifiable, Codable {
    
    var Id: String
    var Nombre: String
    var Fecha: Date
    var IdSupervisor: String
    var IdEmpresa: String
    var Borrado: Bool
    
    var id: String {
        return Id
    }
    
}
