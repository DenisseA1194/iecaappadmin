//
//  File15.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class InstructoresIdiomasAPIService {
  
    private let webService = WebService()
        static let shared = InstructoresIdiomasAPIService()
    
    func editarInstructoresIdiomas(instructoresIdiomas: InstructoresIdiomas, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/InstructoresIdiomas/\(instructoresIdiomas.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Fecha": formattedDate,
            "CompresionAuditiva":instructoresIdiomas.CompresionAuditiva,
            "CompresionLectura": instructoresIdiomas.CompresionLectura,
            "ProduccionEscrita": instructoresIdiomas.ProduccionEscrita,
            "ProduccionVerbal": instructoresIdiomas.ProduccionVerbal,
            "Certificacion": instructoresIdiomas.Certificacion,
            "PuntajeObtenido":instructoresIdiomas.PuntajeObtenido,
            "NivelDeCompetencia":instructoresIdiomas.NivelDeCompetencia,
            "IdInstructor":instructoresIdiomas.IdInstructor,
            "IdEmpresa":instructoresIdiomas.IdEmpresa
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

    
    func eliminarInstructoresIdiomas(idInstructoresIdiomas: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/InstructoresIdiomas/\(idInstructoresIdiomas)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchInstructoresIdiomas(completion: @escaping (Result<[InstructoresIdiomas], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/InstructoresIdiomas?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [InstructoresIdiomas].self) { response in
                    switch response.result {
                    case .success(let instructoresIdiomas):
                        completion(.success(instructoresIdiomas))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarInstructoresIdiomas(nuevoInstructoresIdiomas: InstructoresIdiomas, completion: @escaping (Result<InstructoresIdiomas, Error>) -> Void) {
           let parameters: [String: Any] = [
            "Fecha": nuevoInstructoresIdiomas.Fecha,
            "CompresionAuditiva":nuevoInstructoresIdiomas.CompresionAuditiva,
            "CompresionLectura": nuevoInstructoresIdiomas.CompresionLectura,
            "ProduccionEscrita": nuevoInstructoresIdiomas.ProduccionEscrita,
            "ProduccionVerbal": nuevoInstructoresIdiomas.ProduccionVerbal,
            "Certificacion": nuevoInstructoresIdiomas.Certificacion,
            "PuntajeObtenido":nuevoInstructoresIdiomas.PuntajeObtenido,
            "NivelDeCompetencia":nuevoInstructoresIdiomas.NivelDeCompetencia,
            "IdInstructor":nuevoInstructoresIdiomas.IdInstructor,
            "IdEmpresa":nuevoInstructoresIdiomas.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/InstructoresIdiomas", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: InstructoresIdiomas.self) { response in
                   switch response.result {
                   case .success(let instructoresIdiomas):
                       completion(.success(instructoresIdiomas))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

