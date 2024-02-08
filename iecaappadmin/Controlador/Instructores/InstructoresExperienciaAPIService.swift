//
//  File11.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class InstructoresExperienciaAPIService {
  
    private let webService = WebService()
        static let shared = InstructoresExperienciaAPIService()
    
    func editarInstructoresExperiencia(instructoresExperiencia: InstructoresExperiencia, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/InstructoresExperiencia/\(instructoresExperiencia.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa":instructoresExperiencia.IdEmpresa,
            "IdInstructor": instructoresExperiencia.IdInstructor,
            "Puesto": instructoresExperiencia.Puesto,
            "PeriodoInicial": formattedDate,
            "PeriodoFinal": formattedDate,
            "Sueldo": instructoresExperiencia.Sueldo,
            "Horario":instructoresExperiencia.Horario,
            "JefeInmediato":instructoresExperiencia.JefeInmediato,
            "Empresa":instructoresExperiencia.Empresa,
            "Ciudad":instructoresExperiencia.Ciudad,
            "Estado": instructoresExperiencia.Estado,
            "Pais": instructoresExperiencia.Pais,
            "Contacto": instructoresExperiencia.Contacto,
            "Telefono":instructoresExperiencia.Telefono,
            "Correo":instructoresExperiencia.Correo,
            "FechaAlta": formattedDate,
            "Direccion":instructoresExperiencia.Direccion,
            "Funciones": instructoresExperiencia.Funciones,
            "MotivoSalida":instructoresExperiencia.MotivoSalida,
            "Notas":instructoresExperiencia.Notas
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

    
    func eliminarInstructoresExperiencia(idInstructoresExperiencia: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/InstructoresExperiencia/\(idInstructoresExperiencia)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchInstructoresExperiencia(completion: @escaping (Result<[InstructoresExperiencia], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/InstructoresExperiencia?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [InstructoresExperiencia].self) { response in
                    switch response.result {
                    case .success(let instructoresExperiencia):
                        completion(.success(instructoresExperiencia))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarInstructoresExperiencia(nuevoInstructoresExperiencia: InstructoresExperiencia, completion: @escaping (Result<InstructoresExperiencia, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa":nuevoInstructoresExperiencia.IdEmpresa,
            "IdInstructor": nuevoInstructoresExperiencia.IdInstructor,
            "Puesto": nuevoInstructoresExperiencia.Puesto,
            "PeriodoInicial": nuevoInstructoresExperiencia.PeriodoInicial,
            "PeriodoFinal": nuevoInstructoresExperiencia.PeriodoFinal,
            "Sueldo": nuevoInstructoresExperiencia.Sueldo,
            "Horario":nuevoInstructoresExperiencia.Horario,
            "JefeInmediato":nuevoInstructoresExperiencia.JefeInmediato,
            "Empresa":nuevoInstructoresExperiencia.Empresa,
            "Ciudad":nuevoInstructoresExperiencia.Ciudad,
            "Estado": nuevoInstructoresExperiencia.Estado,
            "Pais": nuevoInstructoresExperiencia.Pais,
            "Contacto": nuevoInstructoresExperiencia.Contacto,
            "Telefono":nuevoInstructoresExperiencia.Telefono,
            "Correo":nuevoInstructoresExperiencia.Correo,
            "FechaAlta": nuevoInstructoresExperiencia.FechaAlta,
            "Direccion":nuevoInstructoresExperiencia.Direccion,
            "Funciones": nuevoInstructoresExperiencia.Funciones,
            "MotivoSalida":nuevoInstructoresExperiencia.MotivoSalida,
            "Notas":nuevoInstructoresExperiencia.Notas
           ]
        
           AF.request(webService.getBaseURL() + "/api/InstructoresExperiencia", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: InstructoresExperiencia.self) { response in
                   switch response.result {
                   case .success(let instructoresExperiencia):
                       completion(.success(instructoresExperiencia))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

