//  PuestoApiService.swift
//  iecaappadmin
//
//  Created by Omar on 29/02/24.
//

//  PuestoAPIService.swift

import SwiftUI
import Foundation
import Alamofire

class PuestoAPIService {
    
    private let baseURL = "http://webservices.iecapp.com"
    static let shared = PuestoAPIService()
    
    func editarPuesto(puesto: Puesto, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/UsuariosPuestos/\(puesto.Id)"
        print(url)
        let parameters: [String: Any] = [
            "Id": puesto.Id,
            "IdEmpresa": puesto.IdEmpresa,
            "Nombre": puesto.Nombre,
            "Notas": puesto.Notas,
            "Fecha": puesto.Fecha,
            "Borrado": puesto.borrado
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
    
    func eliminarPuesto(idPuesto: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/Puestos/\(idPuesto)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
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
    
    func fetchPuestos(completion: @escaping (Result<[Puesto], Error>) -> Void) {
        let url = baseURL+"/api/UsuariosPuestos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        print(url)
        AF.request(url)
            .validate()
            .responseDecodable(of: [Puesto].self) { response in
                switch response.result {
                case .success(let puestos):
                    completion(.success(puestos))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func agregarPuesto(puesto: Puesto, completion: @escaping (Result<Puesto, Error>) -> Void) {
        let parameters: [String: Any] = [
            "Id": puesto.Id,
            "IdEmpresa": puesto.IdEmpresa,
            "Nombre": puesto.Nombre,
            "Notas": puesto.Notas,
            "Fecha": puesto.Fecha,
            "Borrado": puesto.borrado
            // Aquí van el resto de los campos de Puesto
        ]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print("JSON a enviar:")
            print(jsonString)
        }
        AF.request(baseURL + "/api/UsuariosPuestos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
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


