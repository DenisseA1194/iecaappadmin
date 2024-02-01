//
//  clientesCursos.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct ClientesCursos: Identifiable, Codable {
    
    var Id: String
    var IdEmpresa: String
    var IdInstructor: String
    var FechaInicio: Date
    var FechaFinaliza: Date
    var Tema: String
    var Duracion: String
    var Observaciones: String
    var FechaAlta: Date
    var Calificacion: String
    var Notas: String
    var IdAreaInteres: String
    var IdCliente: String
    var IdModalidad: String
    var IdSucursal: String
    var IdCurso: String
    
    var id: String {
        return Id
    }
    
}
