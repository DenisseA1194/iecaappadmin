//
//  InstructoresPerfil.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct InstructoresPerfil: Identifiable, Codable {
    
    var Id: String
    var Fecha: Date
    var IdInstructor: String
    var IdSucursal: String
    var IdTipoContrato: String
    var DisponibilidadDesplazarse: Bool
    var IdEmpresa: String
    var Borrado: Bool
 
    var id: String {
        return Id
    }
    
}
