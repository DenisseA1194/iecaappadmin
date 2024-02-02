//
//  InstructoresDatosfiscales.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct InstructoresDatosFiscales: Identifiable, Codable {
    
    var Id: String
    var CURP: String
    var RFC: String
    var IMSS: String
    var Infonavit: String
    var FechaAlta: Date
    var Fonacot: String
    var IdInstructor: String
    var IdEmpresa: String
    var IdRazonSocial: String
    var Notas: String
    var Regimen: String
    var Calle: String
    var CodigoPostal: String
    var NumeroExterior: String
    var NumeroInterior: String
    var Colonia: String
    var Localidad: String
    var Municipio: String
    var Estado: String
    var EntreCalles: String
 
    var id: String {
        return Id
    }
    
}
