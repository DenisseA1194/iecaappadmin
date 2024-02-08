//
//  File20.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class ClientesDatosFiscalesAPIService {
  
    private let webService = WebService()
        static let shared = ClientesDatosFiscalesAPIService()
    
    func editarClientesDatosFiscales(clientesDatosFiscales: ClientesDatosFiscales, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/ClientesDatosFiscales/\(clientesDatosFiscales.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa": clientesDatosFiscales.IdEmpresa,
            "IdCliente":clientesDatosFiscales.IdCliente,
            "IdUsuarioRegistro": clientesDatosFiscales.IdUsuarioRegistro,
            "RazonSocial": clientesDatosFiscales.RazonSocial,
            "RFC": clientesDatosFiscales.RFC,
            "FechaAlta": formattedDate,
            "Notas":clientesDatosFiscales.Notas,
            "IdRegimenFiscal": clientesDatosFiscales.IdRegimenFiscal,
            "Direccion": clientesDatosFiscales.Direccion,
            "Localidad": clientesDatosFiscales.Localidad,
            "Municipio":clientesDatosFiscales.Municipio,
            "Estado": clientesDatosFiscales.Estado,
            "CodigoPostal": clientesDatosFiscales.CodigoPostal
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

    
    func eliminarClientesDatosFiscales(idClientesDatosFiscales: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/ClientesDatosFiscales/\(idClientesDatosFiscales)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchClientesDatosFiscales(completion: @escaping (Result<[ClientesDatosFiscales], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/ClientesDatosFiscales?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [ClientesDatosFiscales].self) { response in
                    switch response.result {
                    case .success(let clientesDatosFiscales):
                        completion(.success(clientesDatosFiscales))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarClientesDatosFiscales(nuevoClientesDatosFiscales: ClientesDatosFiscales, completion: @escaping (Result<ClientesDatosFiscales, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa": nuevoClientesDatosFiscales.IdEmpresa,
            "IdCliente":nuevoClientesDatosFiscales.IdCliente,
            "IdUsuarioRegistro": nuevoClientesDatosFiscales.IdUsuarioRegistro,
            "RazonSocial": nuevoClientesDatosFiscales.RazonSocial,
            "RFC": nuevoClientesDatosFiscales.RFC,
            "FechaAlta": nuevoClientesDatosFiscales.FechaAlta,
            "Notas":nuevoClientesDatosFiscales.Notas,
            "IdRegimenFiscal": nuevoClientesDatosFiscales.IdRegimenFiscal,
            "Direccion": nuevoClientesDatosFiscales.Direccion,
            "Localidad": nuevoClientesDatosFiscales.Localidad,
            "Municipio":nuevoClientesDatosFiscales.Municipio,
            "Estado": nuevoClientesDatosFiscales.Estado,
            "CodigoPostal": nuevoClientesDatosFiscales.CodigoPostal
           ]
        
           AF.request(webService.getBaseURL() + "/api/ClientesDatosFiscales", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: ClientesDatosFiscales.self) { response in
                   switch response.result {
                   case .success(let clientesDatosFiscales):
                       completion(.success(clientesDatosFiscales))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

