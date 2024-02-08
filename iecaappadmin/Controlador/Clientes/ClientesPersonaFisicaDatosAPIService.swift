
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class ClientesPersonaFisicaDatosAPIService {
  
    private let webService = WebService()
        static let shared = ClientesPersonaFisicaDatosAPIService()
    
    func editarClientesPersonaFisicaDatos(clientesPersonaFisicaDatos: ClientesPersonaFisicaDatos, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/ClientesPersonaFisicaDatos/\(clientesPersonaFisicaDatos.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdCliente": clientesPersonaFisicaDatos.IdCliente,
            "FechaNacimiento": formattedDate,
            "CorreoPersonal":clientesPersonaFisicaDatos.CorreoPersonal,
            "CorreoInstitucional": clientesPersonaFisicaDatos.CorreoInstitucional,
            "Sexo": clientesPersonaFisicaDatos.Sexo,
            "FechaAlta": formattedDate,
            "TelefonoMovil": clientesPersonaFisicaDatos.TelefonoMovil,
            "TelefonoCasa":clientesPersonaFisicaDatos.TelefonoCasa,
            "IdEstadoCivil": clientesPersonaFisicaDatos.IdEstadoCivil,
            "NumeroHijos": clientesPersonaFisicaDatos.NumeroHijos,
            "NumeroDependientesEconomicos": clientesPersonaFisicaDatos.NumeroDependientesEconomicos,
            "LugarNacimiento":clientesPersonaFisicaDatos.LugarNacimiento,
            "IdNacionalidad": clientesPersonaFisicaDatos.IdNacionalidad,
            "IdPaisOrigen": clientesPersonaFisicaDatos.IdPaisOrigen,
            "IdEmpresa": clientesPersonaFisicaDatos.IdEmpresa,
            "FotoLink":clientesPersonaFisicaDatos.FotoLink,
            "IdProfesion": clientesPersonaFisicaDatos.IdProfesion,
            "IdOcupacion": clientesPersonaFisicaDatos.IdOcupacion,
            "IdGradoDeEstudios": clientesPersonaFisicaDatos.IdGradoDeEstudios
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

    
    func eliminarClientesPersonaFisicaDatos(idClientesPersonaFisicaDatos: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/ClientesPersonaFisicaDatos/\(idClientesPersonaFisicaDatos)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchClientesPersonaFisicaDatos(completion: @escaping (Result<[ClientesPersonaFisicaDatos], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/ClientesPersonaFisicaDatos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [ClientesPersonaFisicaDatos].self) { response in
                    switch response.result {
                    case .success(let clientesPersonaFisicaDatos):
                        completion(.success(clientesPersonaFisicaDatos))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarClientesPersonaFisicaDatos(nuevoClientesPersonaFisicaDatos: ClientesPersonaFisicaDatos, completion: @escaping (Result<ClientesPersonaFisicaDatos, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdCliente": nuevoClientesPersonaFisicaDatos.IdCliente,
            "FechaNacimiento": nuevoClientesPersonaFisicaDatos.FechaNacimiento,
            "CorreoPersonal":nuevoClientesPersonaFisicaDatos.CorreoPersonal,
            "CorreoInstitucional": nuevoClientesPersonaFisicaDatos.CorreoInstitucional,
            "Sexo": nuevoClientesPersonaFisicaDatos.Sexo,
            "FechaAlta": nuevoClientesPersonaFisicaDatos.FechaAlta,
            "TelefonoMovil": nuevoClientesPersonaFisicaDatos.TelefonoMovil,
            "TelefonoCasa":nuevoClientesPersonaFisicaDatos.TelefonoCasa,
            "IdEstadoCivil": nuevoClientesPersonaFisicaDatos.IdEstadoCivil,
            "NumeroHijos": nuevoClientesPersonaFisicaDatos.NumeroHijos,
            "NumeroDependientesEconomicos": nuevoClientesPersonaFisicaDatos.NumeroDependientesEconomicos,
            "LugarNacimiento":nuevoClientesPersonaFisicaDatos.LugarNacimiento,
            "IdNacionalidad": nuevoClientesPersonaFisicaDatos.IdNacionalidad,
            "IdPaisOrigen": nuevoClientesPersonaFisicaDatos.IdPaisOrigen,
            "IdEmpresa": nuevoClientesPersonaFisicaDatos.IdEmpresa,
            "FotoLink":nuevoClientesPersonaFisicaDatos.FotoLink,
            "IdProfesion": nuevoClientesPersonaFisicaDatos.IdProfesion,
            "IdOcupacion": nuevoClientesPersonaFisicaDatos.IdOcupacion,
            "IdGradoDeEstudios": nuevoClientesPersonaFisicaDatos.IdGradoDeEstudios
           ]
        
           AF.request(webService.getBaseURL() + "/api/ClientesPersonaFisicaDatos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: ClientesPersonaFisicaDatos.self) { response in
                   switch response.result {
                   case .success(let clientesPersonaFisicaDatos):
                       completion(.success(clientesPersonaFisicaDatos))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

