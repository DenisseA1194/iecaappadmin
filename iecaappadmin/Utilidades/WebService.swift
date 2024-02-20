//
//  Configuracion.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation

class WebService {
    private var baseURL = ""
    
    func setBaseURL(_ url: String) {
           baseURL = url
       }
    
    func getBaseURL() -> String {
        return baseURL
    }
}
