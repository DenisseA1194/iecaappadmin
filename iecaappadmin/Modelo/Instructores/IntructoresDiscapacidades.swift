//
//  IntructoresDiscapacidades.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct InstructoresDiscapacidades: Identifiable, Codable {
    
    var Id: String
    var IdEmpresa: String
    var Fecha: Date
    var IdInstructor: String
    var IdDiscapacidad: String
    var Notas: String
    var FechaDeteccion: Date
 
    var id: String {
        return Id
    }
    
}
