
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
    
    func editarSucursalTipo(sucursalTipo: SucursalTipo, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/SucursalesTipos/\(sucursalTipo.Id)"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Id": sucursalTipo.Id,
            "Nombre": sucursalTipo.Nombre,
            "Fecha": sucursalTipo.Fecha,
            "IdEmpresa": sucursalTipo.IdEmpresa,
            "Borrado": sucursalTipo.Borrado,
            "Virtual": sucursalTipo.Virtual,
            "Notas": sucursalTipo.Notas
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

    
    func eliminarSucursalTipo(idSucursalTipo: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = baseURL + "/api/SucursalTipo/\(idSucursalTipo)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchSucursalesTipo(completion: @escaping (Result<[SucursalTipo], Error>) -> Void) {
            print(baseURL+"/api/SucursalesTipos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
            AF.request(baseURL+"/api/SucursalesTipos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
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
    
    func agregarSucursalTipo(nuevaSucursalTipo: SucursalTipo, completion: @escaping (Result<SucursalTipo, Error>) -> Void) {
           let parameters: [String: Any] = [
            "Id": nuevaSucursalTipo.Id,
            "Nombre": nuevaSucursalTipo.Nombre,
            "Fecha": nuevaSucursalTipo.Fecha,
            "IdEmpresa": nuevaSucursalTipo.IdEmpresa,
            "Borrado": nuevaSucursalTipo.Borrado,
            "Virtual": nuevaSucursalTipo.Virtual,
            "Notas": nuevaSucursalTipo.Notas
           ]
        
           AF.request(baseURL + "/api/SucursalesTipos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
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
