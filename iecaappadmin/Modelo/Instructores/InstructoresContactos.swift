//
//  InstructoresContactos.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct InstructoresContactos: Identifiable, Codable {
    
    var Id: String
    var IdInstructor: String
    var IdEmpresa: String
    var NombreCompleto: String
    var Telefono: String
    var Correo: String
    var Relacion: String
    var Observaciones: String
    var Edad: String
    var Ocupacion: String
    var Notas: String
    var Direccion: String
    var FechaAlta: Date
 
    var id: String {
        return Id
    }
    
}
