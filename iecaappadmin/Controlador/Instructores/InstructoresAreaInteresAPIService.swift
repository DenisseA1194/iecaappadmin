//
//  File.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class InstructoresAreaInteresAPIService {
  
    private let webService = WebService()
    static let shared = InstructoresAreaInteresAPIService()
    
    func editarInstructoresAreaInteres(instructoresAreaInteres: InstructoresAreaInteres, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/InstructoresAreaInteres/\(instructoresAreaInteres.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Fecha": formattedDate,
            "IdAreaInteres":instructoresAreaInteres.IdAreaInteres,
            "Lunes": instructoresAreaInteres.Lunes,
            "Martes": instructoresAreaInteres.Martes,
            "Miercoles": instructoresAreaInteres.Miercoles,
            "Jueves": instructoresAreaInteres.Jueves,
            "Viernes":instructoresAreaInteres.Viernes,
            "Sabado":instructoresAreaInteres.Sabado,
            "Domingo":instructoresAreaInteres.Domingo,
            "LunesInicia":instructoresAreaInteres.LunesInicia,
            "LunesTermina":instructoresAreaInteres.LunesTermina,
            "MartesInicia":instructoresAreaInteres.MartesInicia,
            "MartesTermina":instructoresAreaInteres.MartesTermina,
            "MiercolesInicia":instructoresAreaInteres.MiercolesInicia,
            "MiercolesTermina":instructoresAreaInteres.MiercolesTermina,
            "JuevesInicia":instructoresAreaInteres.JuevesInicia,
            "JuevesTermina":instructoresAreaInteres.JuevesTermina,
            "ViernesInicia":instructoresAreaInteres.ViernesInicia,
            "ViernesTermina":instructoresAreaInteres.ViernesTermina,
            "SabadoInicia":instructoresAreaInteres.SabadoInicia,
            "SabadoTermina":instructoresAreaInteres.SabadoTermina,
            "DomingoInicia":instructoresAreaInteres.SabadoInicia,
            "DomingoTermina":instructoresAreaInteres.SabadoTermina,
            "Nota":instructoresAreaInteres.Nota,
            "IdEmpresa":instructoresAreaInteres.IdEmpresa
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

    
    func eliminarInstructoresAreaInteres(idInstructoresAreaInteres: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/InstructoresAreaInteres/\(idInstructoresAreaInteres)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchInstructoresAreaInteres(completion: @escaping (Result<[InstructoresAreaInteres], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/InstructoresAreaInteres?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [InstructoresAreaInteres].self) { response in
                    switch response.result {
                    case .success(let instructoresAreaInteres):
                        completion(.success(instructoresAreaInteres))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarInstructoresAreaInteres(nuevoInstructoresAreaInteres: InstructoresAreaInteres, completion: @escaping (Result<InstructoresAreaInteres, Error>) -> Void) {
           let parameters: [String: Any] = [
            "Fecha": nuevoInstructoresAreaInteres.Fecha,
            "IdAreaInteres":nuevoInstructoresAreaInteres.IdAreaInteres,
            "Lunes": nuevoInstructoresAreaInteres.Lunes,
            "Martes": nuevoInstructoresAreaInteres.Martes,
            "Miercoles": nuevoInstructoresAreaInteres.Miercoles,
            "Jueves": nuevoInstructoresAreaInteres.Jueves,
            "Viernes":nuevoInstructoresAreaInteres.Viernes,
            "Sabado":nuevoInstructoresAreaInteres.Sabado,
            "Domingo":nuevoInstructoresAreaInteres.Domingo,
            "LunesInicia":nuevoInstructoresAreaInteres.LunesInicia,
            "LunesTermina":nuevoInstructoresAreaInteres.LunesTermina,
            "MartesInicia":nuevoInstructoresAreaInteres.MartesInicia,
            "MartesTermina":nuevoInstructoresAreaInteres.MartesTermina,
            "MiercolesInicia":nuevoInstructoresAreaInteres.MiercolesInicia,
            "MiercolesTermina":nuevoInstructoresAreaInteres.MiercolesTermina,
            "JuevesInicia":nuevoInstructoresAreaInteres.JuevesInicia,
            "JuevesTermina":nuevoInstructoresAreaInteres.JuevesTermina,
            "ViernesInicia":nuevoInstructoresAreaInteres.ViernesInicia,
            "ViernesTermina":nuevoInstructoresAreaInteres.ViernesTermina,
            "SabadoInicia":nuevoInstructoresAreaInteres.SabadoInicia,
            "SabadoTermina":nuevoInstructoresAreaInteres.SabadoTermina,
            "DomingoInicia":nuevoInstructoresAreaInteres.SabadoInicia,
            "DomingoTermina":nuevoInstructoresAreaInteres.SabadoTermina,
            "Nota":nuevoInstructoresAreaInteres.Nota,
            "IdEmpresa":nuevoInstructoresAreaInteres.IdEmpresa
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/InstructoresAreaInteres", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: InstructoresAreaInteres.self) { response in
                   switch response.result {
                   case .success(let instructoresAreaInteres):
                       completion(.success(instructoresAreaInteres))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}
