//
//  CatalogoClientesRegimenFiscal.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 01/02/24.
//

import Foundation

struct CatalogoClientesRegimenFiscal: Identifiable, Codable {
    
    var Id: String
    var IdEmpresa: String
    var C_RegimenFiscal: String
    var Descripcion: String
    var Fisica: String
    var Moral: String
    var Borrado: Bool?
    
    var id: String {
        return Id
    }
    
}
