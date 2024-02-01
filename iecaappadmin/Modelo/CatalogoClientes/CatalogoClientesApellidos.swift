//
//  CatalogoClientesApellidos.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CatalogoClientesApellidos: Identifiable, Codable {
    
    var Id: String
    var Apellido: String
    var Fecha: Date
    var IdEmpresa: String
    var Borrado: Bool
    
    var id: String {
        return Id
    }
    
}
