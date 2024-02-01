//
//  Cursos.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct Curso: Identifiable, Codable {
    
    var Id: String
    var Nombre: String
    var Version: String
    var Fecha: Date
    var Borrado: Bool
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
    var IdProfesion: String
    var IdOcupacion: String
    var IdGradoDeEstudios: String
    
    var id: String {
        return Id
    }
    
}
