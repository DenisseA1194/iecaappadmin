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
    var Telefono: String
    var Numero: String
    var Correo: String
    var Pais: String
    var IdTitular: String
    var IdRazonSocial: String
    var IdZona: String
    var Tipo: String
    var Notas: String
    var borrado: Bool
    var Fecha: String
    
    //var Region: String
    //var Latitud: Double
    //var Longitud: Double
//    var Fecha: String
//    var IdRazonSocial: String
//    var IdSucursalTipo: String
//    var IdEmpresa: String
    
    var id: String { // Declaración manual de la propiedad id
            return Id
        }
    
    var fecha: Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Define el formato de la fecha que recibes
           
           return dateFormatter.date(from: Fecha)
       }
}
