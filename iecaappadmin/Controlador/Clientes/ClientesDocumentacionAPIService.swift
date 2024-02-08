//
//  File20.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class ClientesDocumentacionAPIService {
  
    private let webService = WebService()
        static let shared = ClientesDocumentacionAPIService()
    
    func editarClientesDocumentacion(clientesDocumentacion: ClientesDocumentacion, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/ClientesDocumentacion/\(clientesDocumentacion.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdCliente": clientesDocumentacion.IdCliente,
            "IdEmpresa":clientesDocumentacion.IdEmpresa,
            "IdTipoDocumento": clientesDocumentacion.IdTipoDocumento,
            "Emision": formattedDate,
            "Vence": formattedDate,
            "Vigente": clientesDocumentacion.Vigente,
            "Comentarios": clientesDocumentacion.Comentarios,
            "FechaAlta": formattedDate,
            "Link":clientesDocumentacion.Link,
            "Notas": clientesDocumentacion.Notas
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

    
    func eliminarClientesDocumentacion(idClientesDocumentacion: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/ClientesDocumentacion/\(idClientesDocumentacion)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchClientesDocumentacion(completion: @escaping (Result<[ClientesDocumentacion], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/ClientesDocumentacion?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [ClientesDocumentacion].self) { response in
                    switch response.result {
                    case .success(let clientesDocumentacion):
                        completion(.success(clientesDocumentacion))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarClientesDocumentacion(nuevoClientesDocumentacion: ClientesDocumentacion, completion: @escaping (Result<ClientesDocumentacion, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdCliente": nuevoClientesDocumentacion.IdCliente,
            "IdEmpresa":nuevoClientesDocumentacion.IdEmpresa,
            "IdTipoDocumento": nuevoClientesDocumentacion.IdTipoDocumento,
            "Emision": nuevoClientesDocumentacion.Emision,
            "Vence": nuevoClientesDocumentacion.Vence,
            "Vigente": nuevoClientesDocumentacion.Vigente,
            "Comentarios": nuevoClientesDocumentacion.Comentarios,
            "FechaAlta": nuevoClientesDocumentacion.FechaAlta,
            "Link":nuevoClientesDocumentacion.Link,
            "Notas": nuevoClientesDocumentacion.Notas
           ]
        
           AF.request(webService.getBaseURL() + "/api/ClientesDocumentacion", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: ClientesDocumentacion.self) { response in
                   switch response.result {
                   case .success(let clientesDocumentacion):
                       completion(.success(clientesDocumentacion))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

