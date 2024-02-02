//
//  Cursos.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct Curso: Identifiable, Codable {
    
    var Id: String
    var Nombre: String
    var Version: String
    var Fecha: Date
    var Borrado: Bool
    var IdCampoDeFormacion: String
    var IdEspecialidad: String
    var IdTipoConfidencialidad: String
    var IdModalidad: String
    var IdPlataformaLMSUtilizada: String
    var ObjetivoGeneral: String
    var RegistroSTPS: String
    var Proposito: String
    var Objetivo: String
    var Notas: String
    var Codigo: String
    var CodigoCliente: String
    var CodigoInterno: String
    var CodigoAlterno: String
    var Activo: Bool
    var IdEmpresa: String
    
    var id: String {
        return Id
    }
    
}
