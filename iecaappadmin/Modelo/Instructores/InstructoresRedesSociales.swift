//
//  InstructoresRedesSociales.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct InstructoresRedesSociales: Identifiable, Codable {
    
    var Id: String
    var IdEmpresa: String
    var IdInstructor: String
    var FechaAlta: Date
    var Notas: String
    var IdRedSocial: String
    var Borrado: Bool
 
    var id: String {
        return Id
    }
    
}
