//
//  CatalogoCursosPlataformas.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CatalogoCursosPlataformas: Identifiable, Codable {
    
    var Id: String
    var IdEmpresa: String
    var Fecha: Date
    var Nombre: String
    var Notas: String
    var Observaciones: String
    var Marca: String
    var LinkAcceso: String
    var Proveedor: String
    var Sincrona: Bool
    var Asincrona: Bool
    var Status: Bool
    var Borrado: Bool
    
    var id: String {
        return Id
    }
    
}
