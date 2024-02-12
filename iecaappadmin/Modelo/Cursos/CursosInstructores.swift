//
//  CursosInstructores.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CursosInstructores: Identifiable, Codable {
    
    var Id: String
    var Fecha: Date
    var IdEmpresa: String
    var IdCurso: String
    var IdInstructor: String
    var IdModalidad: String
    var IdTipoPlataforma: String
    var Observaciones: String
    var Notas: String
    var CodigoCliente: String
    var Status: String
    var FechaInicio: Date
    var FechaFinaliza: Date
    var Borrado: Bool
    
    var id: String {
        return Id
    }
    
}
