//
//  clientesContratos.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct ClientesContratos: Identifiable, Codable {
    
    var Id: String
    var IdEmpresa: String
    var IdCliente: String
    var FechaFirma: Date
    var FechaTermino: Date
    var Vigencia: Bool
    var DiasCredito: Int
    var NombreResponsable: String
    var Correo: String
    var Celular: String
    var MontoFacturado: Decimal
    var UrlDocumentoFirebase: String
    var FechaAlta: Date
    var IdRazonSocialCliente: String
    var Notas: String
    var Observaciones: String
    
    var id: String {
        return Id
    }
    
}
