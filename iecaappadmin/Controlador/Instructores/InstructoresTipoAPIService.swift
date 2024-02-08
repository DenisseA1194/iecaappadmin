//
//  File19.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class InstructoresTipoAPIService {
  
    private let webService = WebService()
    static let shared = InstructoresTipoAPIService()
    
    func editarInstructoresTipo(instructoresTipo: InstructoresTipo, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/InstructoresTipo/\(instructoresTipo.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": instructoresTipo.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":instructoresTipo.IdEmpresa,
            "IdTipo": instructoresTipo.IdTipo
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

    
    func eliminarInstructoresTipo(idInstructoresTipo: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/InstructoresTipo/\(idInstructoresTipo)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchInstructoresTipo(completion: @escaping (Result<[InstructoresTipo], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/InstructoresTipo?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [InstructoresTipo].self) { response in
                    switch response.result {
                    case .success(let instructoresTipo):
                        completion(.success(instructoresTipo))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarInstructoresTipo(nuevaInstructoresTipo: InstructoresTipo, completion: @escaping (Result<InstructoresTipo, Error>) -> Void) {
           let parameters: [String: Any] = [
            "Nombre": nuevaInstructoresTipo.Nombre,
            "Fecha": nuevaInstructoresTipo.Fecha,
            "IdEmpresa":nuevaInstructoresTipo.IdEmpresa,
            "IdTipo": nuevaInstructoresTipo.IdTipo
           ]
        
           AF.request(webService.getBaseURL() + "/api/InstructoresTipo", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: InstructoresTipo.self) { response in
                   switch response.result {
                   case .success(let instructoresTipo):
                       completion(.success(instructoresTipo))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

