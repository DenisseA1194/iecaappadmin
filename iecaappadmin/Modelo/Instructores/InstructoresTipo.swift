//
//  InstructoresTipo.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct InstructoresTipo: Identifiable, Codable {
    
    var Id: String
    var Nombre: String
    var Fecha: Date
    var IdEmpresa: String
    var Borrado: Bool
    var IdTipo: String
   
    var id: String {
        return Id
    }
    
}

