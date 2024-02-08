//
//  File3.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class InstructoresContratosAPIService {
  
    private let webService = WebService()
        static let shared = InstructoresContratosAPIService()
    
    func editarInstructoresContratos(instructoresContratos: InstructoresContratos, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/InstructoresContratos/\(instructoresContratos.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdInstructor": instructoresContratos.IdInstructor,
            "IdEmpresa":instructoresContratos.IdEmpresa,
            "FechaInicio": formattedDate,
            "FechaTermino": formattedDate,
            "FechaAlta": formattedDate,
            "Activo": instructoresContratos.Activo,
            "Notas": instructoresContratos.Notas,
            "MontoTotal": instructoresContratos.MontoTotal,
            "MontoPorHora": instructoresContratos.MontoPorHora,
            "HorasPorDia":instructoresContratos.HorasPorDia,
            "HorasPorSemana":instructoresContratos.HorasPorSemana,
            "HorasPorMes":instructoresContratos.HorasPorMes,
            "Descripcion": instructoresContratos.Descripcion,
            "LinkDocumento":instructoresContratos.LinkDocumento,
            "IdTipoContrato":instructoresContratos.IdTipoContrato
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

    
    func eliminarInstructoresContratos(idInstructoresContratos: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/InstructoresContratos/\(idInstructoresContratos)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchInstructoresContratos(completion: @escaping (Result<[InstructoresContratos], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/InstructoresContratos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [InstructoresContratos].self) { response in
                    switch response.result {
                    case .success(let instructoresContratos):
                        completion(.success(instructoresContratos))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarInstructoresContratos(nuevoInstructoresContratos: InstructoresContratos, completion: @escaping (Result<InstructoresContratos, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdInstructor": nuevoInstructoresContratos.IdInstructor,
            "IdEmpresa":nuevoInstructoresContratos.IdEmpresa,
            "FechaInicio": nuevoInstructoresContratos.FechaInicio,
            "FechaTermino": nuevoInstructoresContratos.FechaTermino,
            "FechaAlta": nuevoInstructoresContratos.FechaAlta,
            "Activo": nuevoInstructoresContratos.Activo,
            "Notas": nuevoInstructoresContratos.Notas,
            "MontoTotal": nuevoInstructoresContratos.MontoTotal,
            "MontoPorHora": nuevoInstructoresContratos.MontoPorHora,
            "HorasPorDia":nuevoInstructoresContratos.HorasPorDia,
            "HorasPorSemana":nuevoInstructoresContratos.HorasPorSemana,
            "HorasPorMes":nuevoInstructoresContratos.HorasPorMes,
            "Descripcion": nuevoInstructoresContratos.Descripcion,
            "LinkDocumento":nuevoInstructoresContratos.LinkDocumento,
            "IdTipoContrato":nuevoInstructoresContratos.IdTipoContrato
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/InstructoresContratos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: InstructoresContratos.self) { response in
                   switch response.result {
                   case .success(let instructoresContratos):
                       completion(.success(instructoresContratos))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

