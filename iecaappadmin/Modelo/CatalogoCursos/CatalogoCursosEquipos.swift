//
//  CatalogoCursosEquipos.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CatalogoCursosEquipos: Identifiable, Codable {
    
    var Id: String
    var IdEmpresa: String
    var Link: String
    var Fecha: Date
    var Nombre: String
    var Notas: String
    var Observaciones: String
    var Marca: String
    var Modelo: String
    var Status: Bool
    var Borrado: Bool
    
    var id: String {
        return Id
    }
    
}
