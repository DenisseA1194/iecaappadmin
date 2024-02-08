//
//  File.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire


class ClienteAPIService {
  
    private let baseURL = "http://webservices.iecapp.com"
    static let shared = ClienteAPIService()
    
    func editarCliente(cliente: Cliente, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/Cliente/\(cliente.IdCliente)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        let parameters: [String: Any] = [
            
            "IdCliente":cliente.IdCliente,
            "IdEmpresa": cliente.IdEmpresa,
            "IdTipo": cliente.IdTipo,
            "EsPersonaFisica": cliente.EsPersonaFisica,
            "Nombre": cliente.Nombre,
            "IdApellidoPaterno": cliente.IdApellidoPaterno,
            "IdApellidoMaterno":cliente.IdApellidoMaterno,
            "NombreComercial":"2024-01-30T19:06:05.675Z",
            "IdPropietario":cliente.IdPropietario,
            "IdCelula":cliente.IdCelula,
            "IdSector": cliente.Latitud,
            "IdMedioCaptacion":cliente.Longitud,
            "IdPlataforma":cliente.IdPlataforma,
            "IdSucursal":cliente.IdSucursal,
            "IdClasificacion":cliente.IdClasificacion,
            "Fecha": cliente.Fecha,
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
           let url = baseURL + "/api/Clientes/\(idCliente)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
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

        func fetchClientes(completion: @escaping (Result<[Cliente], Error>) -> Void) {
            AF.request(baseURL+"/ObtenerClientes?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [Cliente].self) { response in
                    switch response.result {
                    case .success(let clientes):
                        completion(.success(clientes))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCliente(cliente: Cliente, completion: @escaping (Result<Cliente, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdCliente":cliente.IdCliente,
            "IdEmpresa": cliente.IdEmpresa,
            "IdTipo": cliente.IdTipo,
            "EsPersonaFisica": cliente.EsPersonaFisica,
            "Nombre": cliente.Nombre,
            "IdApellidoPaterno": cliente.IdApellidoPaterno,
            "IdApellidoMaterno":cliente.IdApellidoMaterno,
            "NombreComercial":"2024-01-30T19:06:05.675Z",
            "IdPropietario":cliente.IdPropietario,
            "IdCelula":cliente.IdCelula,
            "IdSector": cliente.Latitud,
            "IdMedioCaptacion":cliente.Longitud,
            "IdPlataforma":cliente.IdPlataforma,
            "IdSucursal":cliente.IdSucursal,
            "IdClasificacion":cliente.IdClasificacion,
            "Fecha": cliente.Fecha,
            "Status":cliente.Status,
            "Observaciones":cliente.Observaciones,
            "CodigoRegistro":cliente.CodigoRegistro,
            "Latitud":cliente.Latitud,
            "Longitud":cliente.Longitud
              
           ]
        
           AF.request(baseURL + "/api/Cliente", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: Cliente.self) { response in
                   switch response.result {
                   case .success(let curso):
                       completion(.success(cliente))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}
