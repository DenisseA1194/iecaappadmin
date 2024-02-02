//
//  InstructoresCuentasBancarias.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct InstructoresCuentasBancarias: Identifiable, Codable {
    
    var Id: String
    var IdInstructor: String
    var NumeroCuenta: String
    var NumeroTarjeta: String
    var CuentaClabe: String
    var Sucursal: String
    var Notas: String
    var Fecha: Date
    var IdEmpresa: String
    var Activo: Bool
    var Borrado: Bool
    var IdBanco: String

 
    var id: String {
        return Id
    }
    
}
