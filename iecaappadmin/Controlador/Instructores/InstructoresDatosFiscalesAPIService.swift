//
//  File5.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class InstructoresDatosFiscalesAPIService {
  
    private let webService = WebService()
        static let shared = InstructoresDatosFiscalesAPIService()
    
    func editarInstructoresDatosFiscales(instructoresDatosFiscales: InstructoresDatosFiscales, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/InstructoresDatosFiscales/\(instructoresDatosFiscales.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "CURP": instructoresDatosFiscales.CURP,
            "RFC":instructoresDatosFiscales.RFC,
            "IMSS": instructoresDatosFiscales.IMSS,
            "Infonavit": instructoresDatosFiscales.Infonavit,
            "FechaAlta": formattedDate,
            "Fonacot": instructoresDatosFiscales.Fonacot,
            "IdInstructor": instructoresDatosFiscales.IdInstructor,
            "IdEmpresa":instructoresDatosFiscales.IdEmpresa,
            "IdRazonSocial":instructoresDatosFiscales.IdRazonSocial,
            "Notas":instructoresDatosFiscales.Notas,
            "Regimen": instructoresDatosFiscales.Regimen,
            "Calle": instructoresDatosFiscales.Calle,
            "CodigoPostal":instructoresDatosFiscales.CodigoPostal,
            "NumeroExterior":instructoresDatosFiscales.NumeroExterior,
            "NumeroInterior":instructoresDatosFiscales.NumeroInterior,
            "Colonia": instructoresDatosFiscales.Colonia,
            "Localidad": instructoresDatosFiscales.Localidad,
            "Municipio":instructoresDatosFiscales.Municipio,
            "Estado":instructoresDatosFiscales.Estado,
            "EntreCalles":instructoresDatosFiscales.EntreCalles
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

    
    func eliminarInstructoresDatosFiscales(idInstructoresDatosFiscales: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/InstructoresDatosFiscales/\(idInstructoresDatosFiscales)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchInstructoresDatosFiscales(completion: @escaping (Result<[InstructoresDatosFiscales], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/InstructoresDatosFiscales?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [InstructoresDatosFiscales].self) { response in
                    switch response.result {
                    case .success(let instructoresDatosFiscales):
                        completion(.success(instructoresDatosFiscales))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarInstructoresDatosFiscales(nuevoInstructoresDatosFiscales: InstructoresDatosFiscales, completion: @escaping (Result<InstructoresDatosFiscales, Error>) -> Void) {
           let parameters: [String: Any] = [
            "CURP": nuevoInstructoresDatosFiscales.CURP,
            "RFC":nuevoInstructoresDatosFiscales.RFC,
            "IMSS": nuevoInstructoresDatosFiscales.IMSS,
            "Infonavit": nuevoInstructoresDatosFiscales.Infonavit,
            "FechaAlta": nuevoInstructoresDatosFiscales.FechaAlta,
            "Fonacot": nuevoInstructoresDatosFiscales.Fonacot,
            "IdInstructor": nuevoInstructoresDatosFiscales.IdInstructor,
            "IdEmpresa":nuevoInstructoresDatosFiscales.IdEmpresa,
            "IdRazonSocial":nuevoInstructoresDatosFiscales.IdRazonSocial,
            "Notas":nuevoInstructoresDatosFiscales.Notas,
            "Regimen": nuevoInstructoresDatosFiscales.Regimen,
            "Calle": nuevoInstructoresDatosFiscales.Calle,
            "CodigoPostal":nuevoInstructoresDatosFiscales.CodigoPostal,
            "NumeroExterior":nuevoInstructoresDatosFiscales.NumeroExterior,
            "NumeroInterior":nuevoInstructoresDatosFiscales.NumeroInterior,
            "Colonia": nuevoInstructoresDatosFiscales.Colonia,
            "Localidad": nuevoInstructoresDatosFiscales.Localidad,
            "Municipio":nuevoInstructoresDatosFiscales.Municipio,
            "Estado":nuevoInstructoresDatosFiscales.Estado,
            "EntreCalles":nuevoInstructoresDatosFiscales.EntreCalles
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/InstructoresDatosFiscales", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: InstructoresDatosFiscales.self) { response in
                   switch response.result {
                   case .success(let instructoresDatosFiscales):
                       completion(.success(instructoresDatosFiscales))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

