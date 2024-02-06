//
//  SucursalApiService.swift
//  iecaappadmin
//
//  Created by Omar on 06/02/24.
//

import Foundation
import Alamofire



class SucursalAPIService {
  
    private let baseURL = "http://webservices.iecapp.com"
        static let shared = SucursalAPIService()
    
    func editarSucursal(sucursal: Sucursal, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/Sucursal/\(sucursal.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        let parameters: [String: Any] = [
            "Nombre": sucursal.Nombre,
            "IdEmpresa":sucursal.IdEmpresa,
            "Direccion": sucursal.Direccion,
            "Ciudad": sucursal.Ciudad,
            "Region": sucursal.Region,
            "Latitud": sucursal.Latitud,
            "Longitud":sucursal.Longitud,
            "Fecha":"2024-01-30T19:06:05.675Z",
            "IdRazonSocial":sucursal.IdRazonSocial,
            "IdSucursalTipo":sucursal.IdSucursalTipo
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

    
    func eliminarSucursal(idSucursal: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = baseURL + "/api/Sucursal/\(idSucursal)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchSucursales(completion: @escaping (Result<[Sucursal], Error>) -> Void) {
            AF.request(baseURL+"/api/Sucursal?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [Sucursal].self) { response in
                    switch response.result {
                    case .success(let sucursales):
                        completion(.success(sucursales))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarSucursal(nuevaSucursal: Sucursal, completion: @escaping (Result<Sucursal, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevaSucursal.Nombre,
               "IdEmpresa":nuevaSucursal.IdEmpresa,
               "Direccion": nuevaSucursal.Direccion,
               "Ciudad": nuevaSucursal.Ciudad,
               "Region": nuevaSucursal.Region,
               "Latitud": nuevaSucursal.Latitud,
               "Longitud":nuevaSucursal.Longitud,
               "Fecha":nuevaSucursal.Fecha,
               "IdRazonSocial":nuevaSucursal.IdRazonSocial,
               "IdSucursalTipo":nuevaSucursal.IdSucursalTipo
              
           ]
        
           AF.request(baseURL + "/api/Sucursal", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: Sucursal.self) { response in
                   switch response.result {
                   case .success(let sucursal):
                       completion(.success(sucursal))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}
