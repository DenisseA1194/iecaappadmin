//
//  File8.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class InstructoresDomiciliosAPIService {
  
    private let webService = WebService()
        static let shared = InstructoresDomiciliosAPIService()
    
    func editarInstructoresDomicilios(instructoresDomicilios: InstructoresDomicilios, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/InstructoresDomicilios/\(instructoresDomicilios.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdInstructor": instructoresDomicilios.IdInstructor,
            "Calle":instructoresDomicilios.Calle,
            "NumeroInterior": instructoresDomicilios.NumeroInterior,
            "NumeroExterior": instructoresDomicilios.NumeroExterior,
            "Colonia": instructoresDomicilios.Colonia,
            "Localidad": instructoresDomicilios.Localidad,
            "Municipio":instructoresDomicilios.Municipio,
            "Estado":instructoresDomicilios.Estado,
            "CodigoPostal":instructoresDomicilios.CodigoPostal,
            "IdPais":instructoresDomicilios.IdPais,
            "FechaAlta": formattedDate,
            "IdEmpresa":instructoresDomicilios.IdEmpresa,
            "Activo":instructoresDomicilios.Activo,
            "Notas":instructoresDomicilios.Notas
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

    
    func eliminarInstructoresDomicilios(idInstructoresDomicilios: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/InstructoresDomicilios/\(idInstructoresDomicilios)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchInstructoresDomicilios(completion: @escaping (Result<[InstructoresDomicilios], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/InstructoresDomicilios?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [InstructoresDomicilios].self) { response in
                    switch response.result {
                    case .success(let instructoresDomicilios):
                        completion(.success(instructoresDomicilios))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarInstructoresDomicilios(nuevoInstructoresDomicilios: InstructoresDomicilios, completion: @escaping (Result<InstructoresDomicilios, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdInstructor": nuevoInstructoresDomicilios.IdInstructor,
            "Calle":nuevoInstructoresDomicilios.Calle,
            "NumeroInterior": nuevoInstructoresDomicilios.NumeroInterior,
            "NumeroExterior": nuevoInstructoresDomicilios.NumeroExterior,
            "Colonia": nuevoInstructoresDomicilios.Colonia,
            "Localidad": nuevoInstructoresDomicilios.Localidad,
            "Municipio":nuevoInstructoresDomicilios.Municipio,
            "Estado":nuevoInstructoresDomicilios.Estado,
            "CodigoPostal":nuevoInstructoresDomicilios.CodigoPostal,
            "IdPais":nuevoInstructoresDomicilios.IdPais,
            "FechaAlta": nuevoInstructoresDomicilios.FechaAlta,
            "IdEmpresa":nuevoInstructoresDomicilios.IdEmpresa,
            "Activo":nuevoInstructoresDomicilios.Activo,
            "Notas":nuevoInstructoresDomicilios.Notas
           ]
        
           AF.request(webService.getBaseURL() + "/api/InstructoresDomicilios", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: InstructoresDomicilios.self) { response in
                   switch response.result {
                   case .success(let instructoresDomicilios):
                       completion(.success(instructoresDomicilios))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

