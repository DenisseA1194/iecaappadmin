//
//  CursosAutorizaciones.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CursosAutorizaciones: Identifiable, Codable {
    
    var Id: String
    var IdCurso: String
    var IdUsuario: String
    var FechaOperacion: Date
    var Elabora: Bool
    var Revisa: Bool
    var Valida: Bool
    var Aprueba: Bool
    var Autoriza: Bool
    var Notas: String
    var Observaciones: String
    var Fecha: Date
    var IdEmpresa: String
    var Borrado: Bool

    var id: String {
        return Id
    }
    
}
