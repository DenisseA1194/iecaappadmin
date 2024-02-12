//
//  InstructoresExperiencia.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct InstructoresExperiencia: Identifiable, Codable {
    
    var Id: String
    var IdEmpresa: String
    var IdInstructor: String
    var Puesto: String
    var PeriodoInicial: Date
    var PeriodoFinal: Date
    var Sueldo: Decimal
    var Horario: String
    var JefeInmediato: String
    var Empresa: String
    var Ciudad: String
    var Estado: String
    var Pais: String
    var Contacto: String
    var Telefono: String
    var Correo: String
    var FechaAlta: Date
    var Direccion: String
    var Funciones: String
    var MotivoSalida: String
    var Notas: String
    var Borrado: Bool
    
    var id: String {
        return Id
    }
    
}
