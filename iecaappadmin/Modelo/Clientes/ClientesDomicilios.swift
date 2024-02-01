//
//  ClientesDomicilios.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct ClientesDomicilios: Identifiable, Codable {
    
    var Id: String
    var IdCliente: String
    var Calle: String
    var NumeroInterior: String
    var NumeroExterior: String
    var Colonia: String
    var Localidad: String
    var Municipio: String
    var Estado: String
    var CodigoPostal: String
    var IdPais: String
    var FechaAlta: Date
    var IdEmpresa: String
    var Activo: Bool
    var Notas: String

    
    var id: String {
        return Id
    }
    
}
