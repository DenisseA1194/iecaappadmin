//
//  File20.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class InstructoresTiposDeSangreAPIService {
  
    private let webService = WebService()
        static let shared = InstructoresTiposDeSangreAPIService()
    
    func editarInstructoresTiposDeSangre(instructoresTiposDeSangre: InstructoresTiposDeSangre, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/InstructoresTiposDeSangre/\(instructoresTiposDeSangre.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Fecha": formattedDate,
            "IdInstructor": instructoresTiposDeSangre.IdInstructor,
            "IdTipoSangre":instructoresTiposDeSangre.IdTipoSangre,
            "Notas": instructoresTiposDeSangre.Notas,
            "IdEmpresa": instructoresTiposDeSangre.IdEmpresa
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

    
    func eliminarInstructoresTiposDeSangre(idInstructoresTiposDeSangre: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/InstructoresTiposDeSangre/\(idInstructoresTiposDeSangre)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchInstructoresTiposDeSangre(completion: @escaping (Result<[InstructoresTiposDeSangre], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/InstructoresTiposDeSangre?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [InstructoresTiposDeSangre].self) { response in
                    switch response.result {
                    case .success(let instructoresTiposDeSangre):
                        completion(.success(instructoresTiposDeSangre))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarInstructoresTiposDeSangre(nuevaInstructoresTiposDeSangre: InstructoresTiposDeSangre, completion: @escaping (Result<InstructoresTiposDeSangre, Error>) -> Void) {
           let parameters: [String: Any] = [
            "Fecha": nuevaInstructoresTiposDeSangre.Fecha,
            "IdInstructor": nuevaInstructoresTiposDeSangre.IdInstructor,
            "IdTipoSangre":nuevaInstructoresTiposDeSangre.IdTipoSangre,
            "Notas": nuevaInstructoresTiposDeSangre.Notas,
            "IdEmpresa": nuevaInstructoresTiposDeSangre.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/InstructoresTiposDeSangre", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: InstructoresTiposDeSangre.self) { response in
                   switch response.result {
                   case .success(let instructoresTiposDeSangre):
                       completion(.success(instructoresTiposDeSangre))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

