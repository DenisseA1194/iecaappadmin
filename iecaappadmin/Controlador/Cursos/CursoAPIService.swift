
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class CursoAPIService {
  
    private let webService = WebService()
        static let shared = CursoAPIService()
    
    func editarCurso(curso: Curso, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/Cursos/\(curso.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": curso.Nombre,
            "Version":curso.Version,
            "Fecha": formattedDate,
            "IdCampoDeFormacion": curso.IdCampoDeFormacion,
            "IdEspecialidad": curso.IdEspecialidad,
            "IdTipoConfidencialidad": curso.IdTipoConfidencialidad,
            "IdModalidad":curso.IdModalidad,
            "IdPlataformaLMSUtilizada": curso.IdPlataformaLMSUtilizada,
            "ObjetivoGeneral": curso.ObjetivoGeneral,
            "RegistroSTPS": curso.RegistroSTPS,
            "Proposito":curso.Proposito,
            "Objetivo": curso.Objetivo,
            "Notas": curso.Notas,
            "Codigo": curso.Codigo,
            "CodigoCliente":curso.CodigoCliente,
            "CodigoInterno": curso.CodigoInterno,
            "CodigoAlterno": curso.CodigoAlterno,
            "Activo": curso.Activo,
            "IdEmpresa": curso.IdEmpresa
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

    
    func eliminarCurso(idCurso: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/Cursos/\(idCurso)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCurso(completion: @escaping (Result<[Curso], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/Cursos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [Curso].self) { response in
                    switch response.result {
                    case .success(let curso):
                        completion(.success(curso))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCurso(nuevoCurso: Curso, completion: @escaping (Result<Curso, Error>) -> Void) {
           let parameters: [String: Any] = [
            "Nombre": nuevoCurso.Nombre,
            "Version":nuevoCurso.Version,
            "Fecha": nuevoCurso.Fecha,
            "IdCampoDeFormacion": nuevoCurso.IdCampoDeFormacion,
            "IdEspecialidad": nuevoCurso.IdEspecialidad,
            "IdTipoConfidencialidad": nuevoCurso.IdTipoConfidencialidad,
            "IdModalidad":nuevoCurso.IdModalidad,
            "IdPlataformaLMSUtilizada": nuevoCurso.IdPlataformaLMSUtilizada,
            "ObjetivoGeneral": nuevoCurso.ObjetivoGeneral,
            "RegistroSTPS": nuevoCurso.RegistroSTPS,
            "Proposito":nuevoCurso.Proposito,
            "Objetivo": nuevoCurso.Objetivo,
            "Notas": nuevoCurso.Notas,
            "Codigo": nuevoCurso.Codigo,
            "CodigoCliente":nuevoCurso.CodigoCliente,
            "CodigoInterno": nuevoCurso.CodigoInterno,
            "CodigoAlterno": nuevoCurso.CodigoAlterno,
            "Activo": nuevoCurso.Activo,
            "IdEmpresa": nuevoCurso.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/Cursos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: Curso.self) { response in
                   switch response.result {
                   case .success(let curso):
                       completion(.success(curso))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

