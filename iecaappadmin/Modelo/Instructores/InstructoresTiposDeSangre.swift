//
//  InstructoresTiposDeSangre.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct InstructoresTiposDeSangre: Identifiable, Codable {
    
    var Id: String
    var Fecha: Date
    var IdInstructor: String
    var IdTipoSangre: String
    var Notas: String
    var Borrado: Bool
    var IdEmpresa: String
   
    var id: String {
        return Id
    }
    
}
