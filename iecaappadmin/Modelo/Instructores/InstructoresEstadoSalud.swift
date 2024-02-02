//
//  InstructoresEstadoSalud.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct InstructoresEstadoSalud: Identifiable, Codable {
    
    var Id: String
    var Notas: String
    var Fecha: Date
    var IdInstructor: String
    var IdEstadoSalud: String
    var Borrado: Bool
    var IdEmpresa: String
 
    var id: String {
        return Id
    }
    
}
