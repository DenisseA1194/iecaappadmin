//
//  clientesContactos.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct ClientesContactos: Identifiable, Codable {
    
    var Id: String
    var IdCliente: String
    var IdEmpresa: String
    var IdPuesto: String
    var IdDepartamento: String
    var NombreCompleto: String
    var Direccion: String
    var Telefono: String
    var Correo: String
    var Notas: String
    var FechaAlta: Date
 
    
    var id: String {
        return Id
    }
    
}
