//
//  clientesDatosCredito.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct ClientesDatosCredito: Identifiable, Codable {
    
    var IdCliente: String
    var FechaAlta: Date
    var IdEmpresa: String
    var Activo: Bool
    var Notas: String
    var Id: String
    var ListaDePrecios: String
    var Descuento: Decimal
    var PlazoDias: Int
    var TasaInteres: Decimal
    var NumeroDePagos: Int
    var Modalidad: String
    var Borrado: Bool
  
    
    var id: String {
        return Id
    }
    
}
