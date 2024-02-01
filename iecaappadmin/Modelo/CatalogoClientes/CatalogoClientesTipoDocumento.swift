//
//  CatalogoClientesTipoDocumento.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CatalogoClientesTipoDocumento: Identifiable, Codable {
    
    var Id: String
    var Nombre: String
    var Fecha: Date
    var IdEmpresa: String
    var Activo: Bool
    var Borrado: Bool
    
    var id: String {
        return Id
    }
    
}
