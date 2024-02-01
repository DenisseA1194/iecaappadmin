//
//  Cliente.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct Cliente: Identifiable, Codable {
    
    var Id: String
    var IdCliente: String
    var IdEmpresa: String
    var IdTipo: String
    var EsPersonaFisica: Bool
    var Nombre: String
    var IdApellidoPaterno: String
    var IdApellidoMaterno: String
    var NombreComercial: String
    var IdPropietario: String
    var IdCelula: String
    var IdSector: String
    var IdMedioCaptacion: String
    var IdPlataforma: String
    var IdSucursal: String
    var IdClasificacion: String
    var Fecha: Date
    var Status: String
    var Observaciones: String
    var CodigoRegistro: String
    var Latitud: Decimal
    var Longitud: Decimal
    
    var id: String {
        return Id
    }
    
}
