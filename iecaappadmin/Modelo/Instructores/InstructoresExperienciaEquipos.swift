//
//  InstructoresExperienciaEquipos.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct InstructoresExperienciaEquipo: Identifiable, Codable {
    
    var Id: String
    var IdEmpresa: String
    var IdInstructor: String
    var FechaAlta: Date
    var Notas: String
    var Experiencia: String
    var IdEquipoHerramienta: String
 
    var id: String {
        return Id
    }
    
}
