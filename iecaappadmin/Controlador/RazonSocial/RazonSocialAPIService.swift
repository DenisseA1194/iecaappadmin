//
//  RazonSocialAPIService.swift
//  iecaappadmin
//
//  Created by Omar on 28/02/24.
//

import SwiftUI
import Foundation
import Alamofire

class RazonSocialAPIService {
    
    private let baseURL = "http://webservices.iecapp.com"
    static let shared = RazonSocialAPIService()
    
    func editarRazonSocial(razonSocial: RazonSocial, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/RazonSocial/\(razonSocial.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        print(url)
        let parameters: [String: Any] = [
            
            "Id": razonSocial.Id,
            "IdEmpresa": "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
            "Nombre": razonSocial.Nombre,
            "Fecha": "2024-01-30T19:06:05.675Z",
            "Representante": razonSocial.Representante,
            "RFC": razonSocial.RFC,
            "Direccion": razonSocial.Direccion,
            "CodigoPostal": razonSocial.CodigoPostal,
            "Ciudad": razonSocial.Ciudad,
            "Colonia": razonSocial.Colonia,
            "Estado": razonSocial.Estado,
            "Pais":razonSocial.Pais,
            "Regimen1": " ",
            "Telefono": razonSocial.Telefono,
            "IMGFIREBASE": " ",
            "borrado": false,
            
            // Aquí van el resto de los campos de RazonSocial
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
    
    func eliminarRazonSocial(idRazonSocial: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/RazonSocial/\(idRazonSocial)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
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
    
    func fetchRazonesSociales(completion: @escaping (Result<[RazonSocial], Error>) -> Void) {
        AF.request(baseURL+"/api/RazonSocial?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
            .validate()
            .responseDecodable(of: [RazonSocial].self) { response in
                switch response.result {
                case .success(let razonesSociales):
                    completion(.success(razonesSociales))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func agregarRazonSocial(razonSocial: RazonSocial, completion: @escaping (Result<RazonSocial, Error>) -> Void) {
        let parameters: [String: Any] = [
            
            "Id": razonSocial.id,
            "IdEmpresa": "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
            "Nombre": razonSocial.Nombre,
            "Fecha": "2024-01-30T19:06:05.675Z",
            "Representante": razonSocial.Representante,
            "RFC": razonSocial.RFC,
            "Direccion": razonSocial.Direccion,
            "CodigoPostal": razonSocial.CodigoPostal,
            "Ciudad": razonSocial.Ciudad,
            "Colonia": razonSocial.Colonia,
            "Estado": razonSocial.Estado,
            "Pais":razonSocial.Pais,
            "Regimen1": " ",
            "Telefono": razonSocial.Telefono,
            "IMGFIREBASE": " ",
            "borrado": false,
            
            // Aquí van el resto de los campos de RazonSocial
        ]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print("JSON a enviar:")
            print(jsonString)
        }
        AF.request(baseURL + "/api/RazonSocial", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
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
//        AF.request(baseURL + "/api/RazonSocial", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
//            .validate()
//            .responseDecodable(of: RazonSocial.self) { response in
//                switch response.result {
//                case .success(let razonSocial):
//                    completion(.success(razonSocial))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
    }
}

