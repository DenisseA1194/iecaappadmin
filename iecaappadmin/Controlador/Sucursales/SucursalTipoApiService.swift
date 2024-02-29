
import Foundation
//
//  SucursalTipoApiService.swift
//  iecaappadmin
//
//  Created by Omar on 06/02/24.
//

import Foundation
import Alamofire

class SucursalTipoAPIService {
  
    private let baseURL = "http://webservices.iecapp.com"
    private let webService = WebService()
    static let shared = SucursalTipoAPIService()
    
    func editarSucursal(sucursal: SucursalTipo, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/SucursalTipo/\(sucursal.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Id": sucursal.Id,
            "Nombre": sucursal.Nombre,
            "Fecha": sucursal.Fecha,
            "IdEmpresa": sucursal.IdEmpresa,
            "borrado": sucursal.borrado,
            "Virtual": sucursal.Virtual,
            "Notas": sucursal.Notas
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
           let url = webService.getBaseURL() + "/api/SucursalTipo/\(idSucursal)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchSucursales(completion: @escaping (Result<[SucursalTipo], Error>) -> Void) {
            print(webService.getBaseURL()+"/api/SucursalTipo?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
            AF.request(baseURL+"/api/SucursalTipo?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [SucursalTipo].self) { response in
                    switch response.result {
                    case .success(let sucursales):
                        completion(.success(sucursales))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarSucursal(nuevaSucursal: SucursalTipo, completion: @escaping (Result<SucursalTipo, Error>) -> Void) {
           let parameters: [String: Any] = [
            "Id": nuevaSucursal.Id,
            "Nombre": nuevaSucursal.Nombre,
            "Fecha": nuevaSucursal.Fecha,
            "IdEmpresa": nuevaSucursal.IdEmpresa,
            "borrado": nuevaSucursal.borrado,
            "Virtual": nuevaSucursal.Virtual,
            "Notas": nuevaSucursal.Notas
           ]
        
           AF.request(webService.getBaseURL() + "/api/SucursalTipo", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: SucursalTipo.self) { response in
                   switch response.result {
                   case .success(let sucursal):
                       completion(.success(sucursal))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}
