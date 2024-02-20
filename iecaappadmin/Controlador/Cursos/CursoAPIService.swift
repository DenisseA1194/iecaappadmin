
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire

class CursoAPIService{
    
    private let baseURL = "http://webservices.iecapp.com"
    static let shared = CursoAPIService()
    
    func editarCurso(curso: Curso, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/Cursos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        let parameters: [String: Any] = [
            
            "Id" : curso.Id,
            "Nombre" : curso.Nombre,
            "Version" : curso.Version,
            "Fecha" : curso.Fecha,
            "Borrado" : curso.Borrado,
            "IdCampoDeFormacion": curso.IdCampoDeFormacion,
            "IdEspecialidad": curso.IdEspecialidad,
            "IdTipoConfidencialidad": curso.IdTipoConfidencialidad,
            "IdModalidad": curso.IdModalidad,
            "IdPlataformaLMSUtilizada": curso.IdPlataformaLMSUtilizada,
            "ObjetivoGeneral": curso.ObjetivoGeneral,
            "RegistroSTPS": curso.RegistroSTPS,
            "Proposito": curso.Proposito,
            "Objetivo": curso.Objetivo,
            "Notas": curso.Notas,
            "Codigo": curso.Codigo,
            "CodigoCliente": curso.CodigoCliente,
            "CodigoInterno": curso.CodigoInterno,
            "CodigoAlterno": curso.CodigoAlterno,
            "Activo": curso.Activo,
            "IdEmpresa": curso.IdEmpresa,
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
           let url = baseURL + "/api/Curso/\(idCurso)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
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

        func fetchCursos(completion: @escaping (Result<[Curso], Error>) -> Void) {
            AF.request(baseURL+"/api/Cursos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [Curso].self) { response in
                    switch response.result {
                    case .success(let cursos):
                        completion(.success(cursos))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCurso(curso: Curso, completion: @escaping (Result<Curso, Error>) -> Void) {
           let parameters: [String: Any] = [
            "Id" : curso.Id,
            "Nombre" : curso.Nombre,
            "Version" : Int(curso.Version),
            "Fecha" : "2024-01-30T19:06:05.675Z",
            "Borrado" : curso.Borrado,
            "IdCampoDeFormacion": curso.IdCampoDeFormacion,
            "IdEspecialidad": curso.IdEspecialidad,
            "IdTipoConfidencialidad": curso.IdTipoConfidencialidad,
            "IdModalidad": curso.IdModalidad,
            "IdPlataformaLMSUtilizada": curso.IdPlataformaLMSUtilizada,
            "ObjetivoGeneral": curso.ObjetivoGeneral,
            "RegistroSTPS": curso.RegistroSTPS,
            "Proposito": curso.Proposito,
            "Objetivo": curso.Objetivo,
            "Notas": curso.Notas,
            "Codigo": curso.Codigo,
            "CodigoCliente": curso.CodigoCliente,
            "CodigoInterno": curso.CodigoInterno,
            "CodigoAlterno": curso.CodigoAlterno,
            "Activo": curso.Activo,
            "IdEmpresa": curso.IdEmpresa,
           ]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                print("JSON a enviar:")
                print(jsonString)
            }

        
           AF.request(baseURL + "/api/Cursos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
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
