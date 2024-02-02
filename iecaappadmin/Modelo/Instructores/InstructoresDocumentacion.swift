//
//  InstructoresDocumentacion.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct InstructoresDocumentacion: Identifiable, Codable {
    
    var Id: String
    var IdInstructor: String
    var IdEmpresa: String
    var IdTipoDocumento: String
    var Emision: Date
    var Vence: Date
    var Vigente: Bool
    var Borrado: Bool
    var Comentarios: String
    var FechaAlta: Date
    var Link: String
    var Notas: String
 
    var id: String {
        return Id
    }
    
}
