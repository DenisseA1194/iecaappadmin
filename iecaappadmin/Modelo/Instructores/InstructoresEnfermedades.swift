//
//  InstructoresEnfermedades.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct InstructoresEnfermedades: Identifiable, Codable {
    
    var Id: String
    var IdEmpresa: String
    var Fecha: Date
    var IdInstructor: String
    var IdEnfermedad: String
    var FechaDeteccion: Date
    var Notas: String
    var Borrado: Bool
 
    var id: String {
        return Id
    }
    
}
