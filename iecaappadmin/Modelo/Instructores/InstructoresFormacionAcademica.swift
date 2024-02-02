//
//  InstructoresFormacionAcademica.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct InstructoresFormacionAcademica: Identifiable, Codable {
    
    var Id: String
    var IdEmpresa: String
    var IdInstructor: String
    var IdInstitucion: String
    var FechaInicio: Date
    var FechaFinaliza: Date
    var Tema: String
    var Duracion: String
    var Observaciones: String
    var FechaAlta: Date
    var Calificacion: String
    var IdTituloObtenido: String
    var Notas: String
    var IdAreaInteres: String
 
    var id: String {
        return Id
    }
    
}
