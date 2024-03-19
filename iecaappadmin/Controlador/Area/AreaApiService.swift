//  AreaApiService.swift
//  iecaappadmin
//
//  Created by Omar on 29/02/24.
//

//  AreaAPIService.swift

import SwiftUI
import Foundation
import Alamofire

class AreaAPIService {
    
    private let baseURL = "http://webservices.iecapp.com"
    static let shared = AreaAPIService()
    
    func editarArea(area: Area, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/CatalogoCursosAreas/\(area.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        print(url)
        let parameters: [String: Any] = [
            "Id": area.Id,
            "IdEmpresa": area.IdEmpresa,
            "Nombre": area.Nombre,
            "Notas": area.Notas,
            "Observaciones": area.Observaciones,
            "Fecha": area.Fecha,
            "Status": area.Status,
            "borrado": area.Borrado
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
    
    func eliminarArea(idArea: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/CatalogoCursosAreas/\(idArea)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
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
    
    func fetchAreas(completion: @escaping (Result<[Area], Error>) -> Void) {
        AF.request(baseURL+"/api/CatalogoCursosAreas?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
            .validate()
            .responseDecodable(of: [Area].self) { response in
                switch response.result {
                case .success(let areas):
                    completion(.success(areas))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func agregarArea(area: Area, completion: @escaping (Result<Area, Error>) -> Void) {
        let parameters: [String: Any] = [
            "Id": area.Id,
            "IdEmpresa": area.IdEmpresa,
            "Nombre": area.Nombre,
            "Notas": area.Notas,
            "Observaciones": area.Observaciones,
            "Fecha": area.Fecha,
            "Status": area.Status,
            "borrado": area.Borrado
        ]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print("JSON a enviar:")
            print(jsonString)
        }
        AF.request(baseURL + "/api/CatalogoCursosAreas", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
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
