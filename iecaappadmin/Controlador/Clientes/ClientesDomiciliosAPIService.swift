//
//  File20.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class ClientesDomiciliosAPIService {
  
    private let webService = WebService()
        static let shared = ClientesDomiciliosAPIService()
    
    func editarClientesDomicilios(clientesDomicilios: ClientesDomicilios, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/ClientesDomicilios/\(clientesDomicilios.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdCliente": clientesDomicilios.IdCliente,
            "Calle":clientesDomicilios.Calle,
            "NumeroInterior": clientesDomicilios.NumeroInterior,
            "NumeroExterior": clientesDomicilios.NumeroExterior,
            "Colonia": clientesDomicilios.Colonia,
            "Localidad":clientesDomicilios.Localidad,
            "Municipio": clientesDomicilios.Municipio,
            "Estado": clientesDomicilios.Estado,
            "CodigoPostal": clientesDomicilios.CodigoPostal,
            "IdPais":clientesDomicilios.IdPais,
            "FechaAlta": formattedDate,
            "IdEmpresa": clientesDomicilios.IdEmpresa,
            "Activo": clientesDomicilios.Activo,
            "Notas": clientesDomicilios.Notas
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

    
    func eliminarClientesDomicilios(idClientesDomicilios: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/ClientesDomicilios/\(idClientesDomicilios)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchClientesDomicilios(completion: @escaping (Result<[ClientesDomicilios], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/ClientesDomicilios?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [ClientesDomicilios].self) { response in
                    switch response.result {
                    case .success(let clientesDomicilios):
                        completion(.success(clientesDomicilios))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarClientesDomicilios(nuevoClientesDomicilios: ClientesDomicilios, completion: @escaping (Result<ClientesDomicilios, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdCliente": nuevoClientesDomicilios.IdCliente,
            "Calle":nuevoClientesDomicilios.Calle,
            "NumeroInterior": nuevoClientesDomicilios.NumeroInterior,
            "NumeroExterior": nuevoClientesDomicilios.NumeroExterior,
            "Colonia": nuevoClientesDomicilios.Colonia,
            "Localidad":nuevoClientesDomicilios.Localidad,
            "Municipio": nuevoClientesDomicilios.Municipio,
            "Estado": nuevoClientesDomicilios.Estado,
            "CodigoPostal": nuevoClientesDomicilios.CodigoPostal,
            "IdPais":nuevoClientesDomicilios.IdPais,
            "FechaAlta": nuevoClientesDomicilios.FechaAlta,
            "IdEmpresa": nuevoClientesDomicilios.IdEmpresa,
            "Activo": nuevoClientesDomicilios.Activo,
            "Notas": nuevoClientesDomicilios.Notas
           ]
        
           AF.request(webService.getBaseURL() + "/api/ClientesDomicilios", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: ClientesDomicilios.self) { response in
                   switch response.result {
                   case .success(let clientesDomicilios):
                       completion(.success(clientesDomicilios))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

