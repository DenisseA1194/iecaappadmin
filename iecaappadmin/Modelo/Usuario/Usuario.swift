//
//  Usuario.swift
//  iecaappadmin
//
//  Created by Omar on 01/03/24.
//

import Foundation


struct Usuarios: Identifiable, Codable {
    
    var Id: String
    var Nombre: String
    var ApellidoPaterno: String
    var ApellidoMaterno: String
    var FechaNacimiento: String
    var Numero: String
    var TelefonoMovil: String
    var TelefonoFijo: String
    var CorreoInstitucional: String
    var CorreoPersonal: String
    var IdSucursal: String
    var IdDepartamento: String
    var IdPuesto: String
    var Estado: Bool
    var FechaIngreso: String
    var Estatus: Bool
    var Notas: String
    var borrado: Bool
    var FechaAlta: String
    var FotoLink: String
    var IdFirebase: String
    var IdEmpresa: String
    
    
    
    var id: String {
            return Id
        }
    
//    var fecha: Date? {
//           let dateFormatter = DateFormatter()
//           dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//           
//           return dateFormatter.date(from: Fecha)
//       }
}
