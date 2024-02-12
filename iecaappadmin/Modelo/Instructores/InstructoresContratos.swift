//
//  InstructoresContratos.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct InstructoresContratos: Identifiable, Codable {
    
    var Id: String
    var IdInstructor: String
    var IdEmpresa: String
    var FechaInicio: Date
    var FechaTermino: Date
    var FechaAlta: Date
    var Activo: Bool
    var Notas: String
    var MontoTotal: Decimal
    var MontoPorHora: Decimal
    var HorasPorDia: Int
    var HorasPorSemana: Int
    var HorasPorMes: Int
    var Descripcion: String
    var LinkDocumento: String
    var IdTipoContrato: String
    var Borrado: Bool
 
    var id: String {
        return Id
    }
    
}
