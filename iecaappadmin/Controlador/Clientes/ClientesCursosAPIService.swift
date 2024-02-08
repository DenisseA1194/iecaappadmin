//
//  File20.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class ClientesCursosAPIService {
  
    private let webService = WebService()
        static let shared = ClientesCursosAPIService()
    
    func editarClientesCursos(clientesCursos: ClientesCursos, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/ClientesCursos/\(clientesCursos.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa": clientesCursos.IdEmpresa,
            "IdInstructor":clientesCursos.IdInstructor,
            "FechaInicio": formattedDate,
            "FechaFinaliza": formattedDate,
            "Tema": clientesCursos.Tema,
            "Duracion": clientesCursos.Duracion,
            "Observaciones": clientesCursos.Observaciones,
            "FechaAlta": formattedDate,
            "Calificacion":clientesCursos.Calificacion,
            "Notas": clientesCursos.Notas,
            "IdAreaInteres": clientesCursos.IdAreaInteres,
            "IdCliente": clientesCursos.IdCliente,
            "IdModalidad":clientesCursos.IdModalidad,
            "IdSucursal": clientesCursos.IdSucursal,
            "IdCurso": clientesCursos.IdCurso
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

    
    func eliminarClientesCursos(idClientesCursos: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/ClientesCursos/\(idClientesCursos)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchClientesCursos(completion: @escaping (Result<[ClientesCursos], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/ClientesCursos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [ClientesCursos].self) { response in
                    switch response.result {
                    case .success(let clientesCursos):
                        completion(.success(clientesCursos))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarClientesCursos(nuevoClientesCursos: ClientesCursos, completion: @escaping (Result<ClientesCursos, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa": nuevoClientesCursos.IdEmpresa,
            "IdInstructor":nuevoClientesCursos.IdInstructor,
            "FechaInicio": nuevoClientesCursos.FechaInicio,
            "FechaFinaliza": nuevoClientesCursos.FechaFinaliza,
            "Tema": nuevoClientesCursos.Tema,
            "Duracion": nuevoClientesCursos.Duracion,
            "Observaciones": nuevoClientesCursos.Observaciones,
            "FechaAlta": nuevoClientesCursos.FechaAlta,
            "Calificacion":nuevoClientesCursos.Calificacion,
            "Notas": nuevoClientesCursos.Notas,
            "IdAreaInteres": nuevoClientesCursos.IdAreaInteres,
            "IdCliente": nuevoClientesCursos.IdCliente,
            "IdModalidad":nuevoClientesCursos.IdModalidad,
            "IdSucursal": nuevoClientesCursos.IdSucursal,
            "IdCurso": nuevoClientesCursos.IdCurso
           ]
        
           AF.request(webService.getBaseURL() + "/api/ClientesCursos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: ClientesCursos.self) { response in
                   switch response.result {
                   case .success(let clientesCursos):
                       completion(.success(clientesCursos))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

