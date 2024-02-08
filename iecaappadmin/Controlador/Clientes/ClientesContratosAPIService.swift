//
//  File20.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class ClientesContratosAPIService {
  
    private let webService = WebService()
        static let shared = ClientesContratosAPIService()
    
    func editarClientesContratos(clientesContratos: ClientesContratos, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/ClientesContratos/\(clientesContratos.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa": clientesContratos.IdEmpresa,
            "IdCliente":clientesContratos.IdCliente,
            "FechaFirma": formattedDate,
            "FechaTermino": formattedDate,
            "Vigencia": clientesContratos.Vigencia,
            "DiasCredito": clientesContratos.DiasCredito,
            "NombreResponsable": clientesContratos.NombreResponsable,
            "Correo":clientesContratos.Correo,
            "Celular": clientesContratos.Celular,
            "MontoFacturado": clientesContratos.MontoFacturado,
            "UrlDocumentoFirebase": clientesContratos.UrlDocumentoFirebase,
            "FechaAlta": formattedDate,
            "IdRazonSocialCliente":clientesContratos.IdRazonSocialCliente,
            "Notas": clientesContratos.Notas,
            "Observaciones": clientesContratos.Observaciones
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

    
    func eliminarClientesContratos(idClientesContratos: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/ClientesContratos/\(idClientesContratos)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchClientesContratos(completion: @escaping (Result<[ClientesContratos], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/ClientesContratos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [ClientesContratos].self) { response in
                    switch response.result {
                    case .success(let clientesContratos):
                        completion(.success(clientesContratos))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarClientesContratos(nuevoClientesContratos: ClientesContratos, completion: @escaping (Result<ClientesContratos, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa": nuevoClientesContratos.IdEmpresa,
            "IdCliente":nuevoClientesContratos.IdCliente,
            "FechaFirma": nuevoClientesContratos.FechaFirma,
            "FechaTermino": nuevoClientesContratos.FechaTermino,
            "Vigencia": nuevoClientesContratos.Vigencia,
            "DiasCredito": nuevoClientesContratos.DiasCredito,
            "NombreResponsable": nuevoClientesContratos.NombreResponsable,
            "Correo":nuevoClientesContratos.Correo,
            "Celular": nuevoClientesContratos.Celular,
            "MontoFacturado": nuevoClientesContratos.MontoFacturado,
            "UrlDocumentoFirebase": nuevoClientesContratos.UrlDocumentoFirebase,
            "FechaAlta": nuevoClientesContratos.FechaAlta,
            "IdRazonSocialCliente":nuevoClientesContratos.IdRazonSocialCliente,
            "Notas": nuevoClientesContratos.Notas,
            "Observaciones": nuevoClientesContratos.Observaciones
           ]
        
           AF.request(webService.getBaseURL() + "/api/ClientesContratos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: ClientesContratos.self) { response in
                   switch response.result {
                   case .success(let clientesContratos):
                       completion(.success(clientesContratos))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

