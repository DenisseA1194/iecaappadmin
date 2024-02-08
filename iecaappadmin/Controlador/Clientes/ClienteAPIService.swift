//
//  File.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class ClienteAPIService {
  
    private let webService = WebService()
    static let shared = ClienteAPIService()
    
    func editarCliente(cliente: Cliente, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/Clientes/\(cliente.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdCliente":cliente.IdCliente,
            "IdEmpresa": cliente.IdEmpresa,
            "IdTipo": cliente.IdTipo,
            "EsPersonaFisica": cliente.EsPersonaFisica,
            "Nombre": cliente.Nombre,
            "IdApellidoPaterno":cliente.IdApellidoPaterno,
            "IdApellidoMaterno": cliente.IdApellidoMaterno,
            "NombreComercial":cliente.NombreComercial,
            "IdPropietario":cliente.IdPropietario,
            "IdCelula":cliente.IdCelula,
            "IdSector":cliente.IdSector,
            "IdMedioCaptacion":cliente.IdMedioCaptacion,
            "IdPlataforma":cliente.IdPlataforma,
            "IdSucursal":cliente.IdSucursal,
            "IdClasificacion":cliente.IdClasificacion,
            "Fecha": formattedDate,
            "Status":cliente.Status,
            "Observaciones":cliente.Observaciones,
            "CodigoRegistro":cliente.CodigoRegistro,
            "Latitud":cliente.Latitud,
            "Longitud":cliente.Longitud
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

    
    func eliminarCliente(idCliente: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/Clientes/\(idCliente)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCliente(completion: @escaping (Result<[Cliente], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/Clientes?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [Cliente].self) { response in
                    switch response.result {
                    case .success(let cliente):
                        completion(.success(cliente))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCliente(nuevoCliente: Cliente, completion: @escaping (Result<Cliente, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdCliente":nuevoCliente.IdCliente,
            "IdEmpresa": nuevoCliente.IdEmpresa,
            "IdTipo": nuevoCliente.IdTipo,
            "EsPersonaFisica": nuevoCliente.EsPersonaFisica,
            "Nombre": nuevoCliente.Nombre,
            "IdApellidoPaterno":nuevoCliente.IdApellidoPaterno,
            "IdApellidoMaterno": nuevoCliente.IdApellidoMaterno,
            "NombreComercial":nuevoCliente.NombreComercial,
            "IdPropietario":nuevoCliente.IdPropietario,
            "IdCelula":nuevoCliente.IdCelula,
            "IdSector":nuevoCliente.IdSector,
            "IdMedioCaptacion":nuevoCliente.IdMedioCaptacion,
            "IdPlataforma":nuevoCliente.IdPlataforma,
            "IdSucursal":nuevoCliente.IdSucursal,
            "IdClasificacion":nuevoCliente.IdClasificacion,
            "Fecha": nuevoCliente.Fecha,
            "Status":nuevoCliente.Status,
            "Observaciones":nuevoCliente.Observaciones,
            "CodigoRegistro":nuevoCliente.CodigoRegistro,
            "Latitud":nuevoCliente.Latitud,
            "Longitud":nuevoCliente.Longitud
           ]
        
           AF.request(webService.getBaseURL() + "/api/Clientes", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: Cliente.self) { response in
                   switch response.result {
                   case .success(let cliente):
                       completion(.success(cliente))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}
