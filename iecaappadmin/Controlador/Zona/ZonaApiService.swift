//
//  ZonaApiService.swift
//  iecaappadmin
//
//  Created by Omar on 29/02/24.
//

//  ZonaAPIService.swift

import SwiftUI
import Foundation
import Alamofire

class ZonaAPIService {
    
    private let baseURL = "http://webservices.iecapp.com"
    static let shared = ZonaAPIService()
    
    func editarZona(zona: Zona, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/Zona/\(zona.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        print(url)
        let parameters: [String: Any] = [
            
            "Id": zona.Id,
            "IdEmpresa": zona.IdEmpresa,
            "Nombre": zona.Nombre,
            "Notas": zona.Notas,
            "Fecha": zona.Fecha,
            "borrado": zona.borrado,
            
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
    
    func eliminarZona(idZona: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/Zona/\(idZona)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
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
    
    func fetchZonas(completion: @escaping (Result<[Zona], Error>) -> Void) {
        AF.request(baseURL+"/api/Zona?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
            .validate()
            .responseDecodable(of: [Zona].self) { response in
                switch response.result {
                case .success(let zonas):
                    completion(.success(zonas))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func agregarZona(zona: Zona, completion: @escaping (Result<Zona, Error>) -> Void) {
        let parameters: [String: Any] = [
            "Id": zona.Id,
            "IdEmpresa": zona.IdEmpresa,
            "Nombre": zona.Nombre,
            "Notas": zona.Notas,
            "Fecha": zona.Fecha,
            "borrado": zona.borrado,
            // Aquí van el resto de los campos de Zona
        ]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print("JSON a enviar:")
            print(jsonString)
        }
        AF.request(baseURL + "/api/Zona", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
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
