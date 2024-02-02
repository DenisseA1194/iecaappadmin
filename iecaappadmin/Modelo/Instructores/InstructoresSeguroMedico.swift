//
//  InstructoresSeguroMedico.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct InstructoresSeguroMedico: Identifiable, Codable {
    
    var Id: String
    var Fecha: Date
    var IdInstructor: String
    var IdSeguroMedico: String
    var FechaIngreso: Date
    var Notas: String
    var FechaVencimiento: Date
    var NumeroAfiliacionPoliza: String
    var Borrado: Bool
    var IdEmpresa: String
 
    var id: String {
        return Id
    }
    
}
