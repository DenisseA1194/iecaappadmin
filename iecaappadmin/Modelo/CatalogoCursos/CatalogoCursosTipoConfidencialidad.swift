//
//  CatalogoCursosTipoConfidencialidad.swift
//  iecaappadmin
//
//  Created by Omar on 07/03/24.
//

import Foundation



struct CatalogoCursosTipoConfidencialidad: Identifiable, Codable {

    
    var Id: String
    var IdEmpresa: String
    var Fecha: String
    var Nombre: String
    var Notas: String
    var Observaciones: String
    var Status: Bool
    var Borrado: Bool?
    
    var id: String {
        return Id
    }
    
}
