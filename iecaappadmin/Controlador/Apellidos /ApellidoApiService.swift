//  ApellidosApiService.swift
//  iecaappadmin
//
//  Created by Omar on 29/02/24.
//

//  ApellidosAPIService.swift

import SwiftUI
import Foundation
import Alamofire

class ApellidoAPIService {
    
    private let baseURL = "http://webservices.iecapp.com"
    static let shared = ApellidoAPIService()
    
    func editarApellidos(apellido: Apellido, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/Apellidos/\(apellido.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        print(url)
        let parameters: [String: Any] = [
            
            "Id": apellido.Id,
            "Apellido": apellido.Apellido,
            "Fecha": apellido.Fecha,
            "IdEmpresa": apellido.IdEmpresa,
            "Borrado": apellido.Borrado,
            
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
    
    func eliminarApellidos(idApellido: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/Apellidos/\(idApellido)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
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
    
    func fetchApellidos(completion: @escaping (Result<[Apellido], Error>) -> Void) {
        AF.request(baseURL+"/api/CatalogoClientesApellidos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
            .validate()
            .responseDecodable(of: [Apellido].self) { response in
                switch response.result {
                case .success(let apellido):
                    completion(.success(apellido))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func agregarApellidos(apellido: Apellido, completion: @escaping (Result<Apellido, Error>) -> Void) {
        let parameters: [String: Any] = [
            "Id": apellido.Id,
            "Apellido": apellido.Apellido,
            "Fecha": apellido.Fecha,
            "IdEmpresa": apellido.IdEmpresa,
            "Borrado": apellido.Borrado,
            // Aquí van el resto de los campos de Apellidos
        ]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print("JSON a enviar:")
            print(jsonString)
        }
        AF.request(baseURL + "/api/Apellidos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
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

