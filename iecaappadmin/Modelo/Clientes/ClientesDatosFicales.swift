//
//  clientesDatosFicales.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct ClientesDatosFiscales: Identifiable, Codable {
    
    var Id: String
    var IdEmpresa: String
    var IdCliente: String
    var IdUsuarioRegistro: String
    var RazonSocial: String
    var RFC: String
    var FechaAlta: Date
    var Borrado: Bool
    var Notas: String
    var IdRegimenFiscal: String
    var Direccion: String
    var Localidad: String
    var Municipio: String
    var Estado: String
    var CodigoPostal: String
    
    var id: String {
        return Id
    }
    
}
