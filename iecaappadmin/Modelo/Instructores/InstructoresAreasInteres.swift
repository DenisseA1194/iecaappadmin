//
//  InstructoresAreasInteres.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct InstructoresAreaInteres: Identifiable, Codable {
    
    var Id: String
    var Fecha: Date
    var IdAreaInteres: String
    var Lunes: Bool
    var Martes: Bool
    var Miercoles: Bool
    var Jueves: Bool
    var Viernes: Bool
    var Sabado: Bool
    var Domingo: Bool
    var LunesInicia: TimeInterval
    var LunesTermina: TimeInterval
    var MartesInicia: TimeInterval
    var MartesTermina: TimeInterval
    var MiercolesInicia: TimeInterval
    var MiercolesTermina: TimeInterval
    var JuevesInicia: TimeInterval
    var JuevesTermina: TimeInterval
    var ViernesInicia: TimeInterval
    var ViernesTermina: TimeInterval
    var SabadoInicia: TimeInterval
    var SabadoTermina: TimeInterval
    var DomingoInicia: TimeInterval
    var DomingoTermina: TimeInterval
    var Nota: String
    var IdEmpresa: String
    var Borrado: Bool

    var id: String {
        return Id
    }
    
}
