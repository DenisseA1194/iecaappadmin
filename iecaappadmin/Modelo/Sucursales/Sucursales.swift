//
//  Sucursales.swift
//  iecaappadmin
//
//  Created by Omar on 06/02/24.
//

import Foundation


struct Sucursal: Identifiable, Codable {
    var Id: String
    var Nombre: String
    var Direccion: String
    var Ciudad: String
    var Region: String
    var Latitud: Double
    var Longitud: Double
    var Fecha: String
    var IdRazonSocial: String
    var IdSucursalTipo: String
    var IdEmpresa: String
    
    var id: String { // Declaración manual de la propiedad id
            return Id
        }
}
