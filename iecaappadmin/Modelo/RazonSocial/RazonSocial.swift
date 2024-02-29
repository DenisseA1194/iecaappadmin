//
//  RazonSocial.swift
//  iecaappadmin
//
//  Created by Omar on 22/02/24.
//

import Foundation
struct RazonSocial: Identifiable, Codable {
    var Id: String
    var IdEmpresa: String?
    var Nombre: String
    var Fecha: String
    //var Usuario: String
    var Representante: String
    var RFC: String
    //var RFC: String
    var Direccion: String
    var CodigoPostal: String
    var Ciudad: String
    var Colonia: String
    var Estado: String
    var Pais: String
    var Regimen1: String
    var Telefono: String
    //var ContribEspecial: Bool
    //var ObligaConta: Bool
    //var NombreComercial: String
    //var RegistroPatronal: String
    var IMGFIREBASE: String
    //var SitioWeb: String
    //var SitioEncuesta: String
    //var borrado: Bool
    //var Notas: String
    
    var id: String {
        return Id
    }
    
    var fecha: Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Define el formato de la fecha que recibes
           
           return dateFormatter.date(from: Fecha)
       }
}
