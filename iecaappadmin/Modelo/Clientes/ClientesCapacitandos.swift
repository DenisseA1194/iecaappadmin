//
//  ClientesCapacitandos.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct ClientesCapacitandos: Identifiable, Codable {
    
    var Id: String
    var CURP: String
    var RenapoDatos: String
    var Nombre: String
    var IdApellidoPaterno: String
    var IdApellidoMaterno: String
    var FechaNacimiento: Date
    var CalleNumero: String
    var Colonia: String
    var CodigoPostal: String
    var Localidad: String
    var MunicipioResidencia: String
    var IdEstadoResidencia: String
    var IdPaisNacimiento: String
    var IdEstadoCivil: String
    var Escolaridad: String
    var MotivoParaInscribirse: String
    var TrabajaActualmente: Bool
    var MotivoNoTrabaja: String
    var IdSucursal: String
    var IdAlumno: String
    var NumeroControl: String
    var CorreoPersonal: Bool
    var CorreoInstitucional: String
    var Sexo: String
    var FechaAlta: Date
    var TelefonoMovil: String
    var TelefonoCasa: String
    var IdCliente: String
    var IdTipoCapacitando: Bool
    var IdEmpresa: String
    var IdModalidad: String
    var FechaIngreso: Date
    var FotoLink: String
    var UuidFirebase: String
    var Borrado: Bool
    
    var id: String {
        return Id
    }
    
}
