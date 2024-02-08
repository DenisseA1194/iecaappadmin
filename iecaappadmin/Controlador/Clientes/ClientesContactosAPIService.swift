//
//  File20.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class ClientesContactosAPIService {
  
    private let webService = WebService()
        static let shared = ClientesContactosAPIService()
    
    func editarClientesContactos(clientesContactos: ClientesContactos, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/ClientesContactos/\(clientesContactos.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdCliente": clientesContactos.IdCliente,
            "IdEmpresa":clientesContactos.IdEmpresa,
            "IdPuesto": clientesContactos.IdPuesto,
            "IdDepartamento": clientesContactos.IdDepartamento,
            "NombreCompleto": clientesContactos.NombreCompleto,
            "Direccion":clientesContactos.Direccion,
            "Telefono": clientesContactos.Telefono,
            "Correo": clientesContactos.Correo,
            "Notas": clientesContactos.Notas,
            "FechaAlta": formattedDate
           
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

    
    func eliminarClientesContactos(idClientesContactos: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/ClientesContactos/\(idClientesContactos)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchClientesContactos(completion: @escaping (Result<[ClientesContactos], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/ClientesContactos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [ClientesContactos].self) { response in
                    switch response.result {
                    case .success(let clientesContactos):
                        completion(.success(clientesContactos))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarClientesContactos(nuevoClientesContactos: ClientesContactos, completion: @escaping (Result<ClientesContactos, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdCliente": nuevoClientesContactos.IdCliente,
            "IdEmpresa":nuevoClientesContactos.IdEmpresa,
            "IdPuesto": nuevoClientesContactos.IdPuesto,
            "IdDepartamento": nuevoClientesContactos.IdDepartamento,
            "NombreCompleto": nuevoClientesContactos.NombreCompleto,
            "Direccion":nuevoClientesContactos.Direccion,
            "Telefono": nuevoClientesContactos.Telefono,
            "Correo": nuevoClientesContactos.Correo,
            "Notas": nuevoClientesContactos.Notas,
            "FechaAlta": nuevoClientesContactos.FechaAlta
           ]
        
           AF.request(webService.getBaseURL() + "/api/ClientesContactos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: ClientesContactos.self) { response in
                   switch response.result {
                   case .success(let clientesContactos):
                       completion(.success(clientesContactos))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

