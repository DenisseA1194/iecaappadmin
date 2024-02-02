//
//  CursosDocumentacion.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CursosDocumentacion: Identifiable, Codable {
    
    var Id: String
    var IdCurso: String
    var IdEmpresa: String
    var Nombre: String
    var Fecha: Date
    var LinkDocumento: String
    var Notas: String
    var Referencias: String
  
    var id: String {
        return Id
    }
    
}
