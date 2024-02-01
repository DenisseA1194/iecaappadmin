//
//  ClientesPersonaFisicaDatos.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct ClientesPersonaFisicaDatos: Identifiable, Codable {
    
    var Id: String
    var IdCliente: String
    var FechaNacimiento: Date
    var CorreoPersonal: String
    var CorreoInstitucional: String
    var Sexo: String
    var FechaAlta: Date
    var TelefonoMovil: String
    var TelefonoCasa: String
    var IdEstadoCivil: String
    var NumeroHijos: Int
    var NumeroDependientesEconomicos: Int
    var LugarNacimiento: String
    var IdNacionalidad: String
    var IdPaisOrigen: String
    var IdEmpresa: String
    var FotoLink: String
    var Borrado: Bool
    var IdProfesion: String
    var IdOcupacion: String
    var IdGradoDeEstudios: String
    
    var id: String {
        return Id
    }
    
}
