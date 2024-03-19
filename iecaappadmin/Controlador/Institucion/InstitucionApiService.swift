//  InstitucionApiService.swift
//  iecaappadmin
//
//  Created by Omar on 29/02/24.
//

//  InstitucionAPIService.swift

import SwiftUI
import Foundation
import Alamofire

class InstitucionAPIService {
    
    private let baseURL = "http://webservices.iecapp.com"
    static let shared = InstitucionAPIService()
    
    func editarInstitucion(institucion: Institucion, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/ActualizarEmpresa?id=\(institucion.Id)"
        print(url)
        let parameters: [String: Any] = [
            
            "Id": institucion.Id,
            "Nombre": institucion.Nombre,
            "LogoLink": institucion.LogoLink,
            "Fecha": institucion.Fecha,
            "Status": institucion.Status,
            "borrado": institucion.borrado,
            "Correo": institucion.Correo,
            "Telefono": institucion.Telefono,
            "Notas": institucion.Notas,
            "IdEmpresa": institucion.IdEmpresa,
            "IdRazonSocial": institucion.IdRazonSocial
            
        ]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print("JSON a enviar:")
            print(jsonString)
        }
        
        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func eliminarInstitucion(idInstitucion: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/Institucion/\(idInstitucion)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        AF.request(url, method: .delete)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchInstituciones(completion: @escaping (Result<[Institucion], Error>) -> Void) {
        AF.request(baseURL+"/ObtenerDatosEmpresa?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
            .validate()
            .responseDecodable(of: [Institucion].self) { response in
                switch response.result {
                case .success(let instituciones):
                    completion(.success(instituciones))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func agregarInstitucion(institucion: Institucion, completion: @escaping (Result<Institucion, Error>) -> Void) {
        let parameters: [String: Any] = [
            "Id": institucion.Id,
            "Nombre": institucion.Nombre,
            "LogoLink": institucion.LogoLink,
            "Fecha": institucion.Fecha,
            "Status": institucion.Status,
            "borrado": institucion.borrado,
            "Correo": institucion.Correo,
            "Telefono": institucion.Telefono,
            "Notas": institucion.Notas,
            "IdEmpresa": institucion.IdEmpresa,
            "IdRazonSocial": institucion.IdRazonSocial
        ]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print("JSON a enviar:")
            print(jsonString)
        }
        AF.request(baseURL + "/api/Institucion", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
            .validate()
            .responseString { response in
                switch response.result {
                case .success(let responseString):
                    // Manejar la cadena de texto de respuesta aquí
                    print("Respuesta del servidor:", responseString)
//                    completion(.success(responseString))
                case .failure(let error):
                    // Manejar el error aquí
                    completion(.failure(error))
                }
            }
    }
}

