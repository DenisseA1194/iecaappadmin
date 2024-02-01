//
//  CatalogoCursosCampoDeFormacion.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CatalogoCursosCampoDeFormacion: Identifiable, Codable {
    
    var Id: String
    var IdEmpresa: String
    var Fecha: Date
    var Nombre: String
    var Notas: String
    var Status: Bool
    var Borrado: Bool
    
    var id: String {
        return Id
    }
    
}
