//
//  InstructoresIdiomas.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct InstructoresIdiomas: Identifiable, Codable {
    
    var Id: String
    var Fecha: Date
    var CompresionAuditiva: Int
    var CompresionLectura: Int
    var ProduccionEscrita: Int
    var ProduccionVerbal: Int
    var Certificacion: String
    var PuntajeObtenido: Int
    var NivelDeCompetencia: String
    var IdInstructor: String
    var IdEmpresa: String
 
    var id: String {
        return Id
    }
    
}
