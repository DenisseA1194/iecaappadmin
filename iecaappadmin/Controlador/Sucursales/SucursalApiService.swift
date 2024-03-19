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
    private let webService = WebService()
    static let shared = SucursalAPIService()
    
    func editarSucursal(sucursal: Sucursal, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/Sucursal/\(sucursal.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        print(url)
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Id": sucursal.Id,
            "Nombre": sucursal.Nombre,
            "Direccion": sucursal.Direccion,
            "Ciudad": sucursal.Ciudad,
            "Telefono": sucursal.Telefono,
            "Numero": sucursal.Numero,
            "Correo": sucursal.Correo,
            "Pais": sucursal.Pais,
            "IdTitular": sucursal.IdTitular,
            "IdRazonSocial": sucursal.IdRazonSocial,
            "IdZona": sucursal.IdZona,
            "IdSucursalTipo": sucursal.IdSucursalTipo,
            "Notas": sucursal.Notas,
            "borrado": sucursal.borrado,
            "Fecha": sucursal.Fecha,
            "LinkImagen": sucursal.LinkImagen,
            "IdEmpresa": sucursal.IdEmpresa
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
           let url = webService.getBaseURL() + "/api/Sucursal/\(idSucursal)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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
            print(webService.getBaseURL()+"/api/Sucursal?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
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
            "Id": nuevaSucursal.Id,
            "Nombre": nuevaSucursal.Nombre,
            "Direccion": nuevaSucursal.Direccion,
            "Ciudad": nuevaSucursal.Ciudad,
            "Telefono": nuevaSucursal.Telefono,
            "Numero": nuevaSucursal.Numero,
            "Correo": nuevaSucursal.Correo,
            "Pais": nuevaSucursal.Pais,
            "IdTitular": nuevaSucursal.IdTitular,
            "IdRazonSocial": nuevaSucursal.IdRazonSocial,
            "IdZona": nuevaSucursal.IdZona,
            "IdSucursalTipo": nuevaSucursal.IdSucursalTipo,
            "Notas": nuevaSucursal.Notas,
            "borrado": nuevaSucursal.borrado,
            "Fecha": nuevaSucursal.Fecha,
            "LinkImagen": nuevaSucursal.LinkImagen,
            "IdEmpresa": nuevaSucursal.IdEmpresa
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
