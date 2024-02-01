//
//  CatalogoClientesDetalles.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CatalogoClientesDetalles: Identifiable, Codable {
    
    var Id: String
    var Nombre: String
    var Fecha: Date
    var IdCatalogoCliente: String
    var IdEmpresa: String
    var Borrado: Bool
    
    var id: String {
        return Id
    }
    
}
