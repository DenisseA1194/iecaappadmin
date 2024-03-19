//
//  Departamento.swift
//  iecaappadmin
//
//  Created by Omar on 04/03/24.
//

import Foundation

struct UsuarioDepartamento: Identifiable, Codable {
    
    var Id: String
    var Nombre: String
    var Fecha: String
    var IdEmpresa: String
    var Borrado: Bool?
    var Notas: String
    
    var id: String {
        return Id
    }
    
}
