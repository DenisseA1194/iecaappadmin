//
//  CursosTemas.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
//import Alamofire
//
//
//
//class ClientesCapacitandosAPIService {
//  
//    private let webService = WebService()
//        static let shared = ClientesCapacitandosAPIService()
//    
//    func editarClientesCapacitandos(clientesCapacitandos: ClientesCapacitandos, completion: @escaping (Result<Void, Error>) -> Void) {
//        let url = webService.getBaseURL() + "/api/ClientesCapacitandos/\(clientesCapacitandos.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
//        
//        // Obtener la fecha actual
//        let currentDate = Date()
//               
//        // Formatear la fecha actual utilizando DateFormatterManager
//        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
//        
//        let parameters: [String: Any] = [
//            "CURP": clientesCapacitandos.CURP,
//            "RenapoDatos":clientesCapacitandos.RenapoDatos,
//            "Nombre": clientesCapacitandos.Nombre,
//            "IdApellidoPaterno": clientesCapacitandos.IdApellidoPaterno,
//            "IdApellidoMaterno": clientesCapacitandos.IdApellidoMaterno,
//            "FechaNacimiento": formattedDate,
//            "CalleNumero":clientesCapacitandos.CalleNumero,
//            "Colonia": clientesCapacitandos.Colonia,
//            "CodigoPostal": clientesCapacitandos.CodigoPostal,
//            "Localidad": clientesCapacitandos.Localidad,
//            "MunicipioResidencia":clientesCapacitandos.MunicipioResidencia,
//            "IdEstadoResidencia": clientesCapacitandos.IdEstadoResidencia,
//            "IdPaisNacimiento": clientesCapacitandos.IdPaisNacimiento,
//            "IdEstadoCivil": clientesCapacitandos.IdEstadoCivil,
//            "Escolaridad":clientesCapacitandos.Escolaridad,
//            "MotivoParaInscribirse": clientesCapacitandos.MotivoParaInscribirse,
//            "TrabajaActualmente": clientesCapacitandos.TrabajaActualmente,
//            "MotivoNoTrabaja": clientesCapacitandos.MotivoNoTrabaja,
//            "IdSucursal": clientesCapacitandos.IdSucursal,
//            "IdAlumno": clientesCapacitandos.IdAlumno,
//            "NumeroControl":clientesCapacitandos.NumeroControl,
//            "CorreoPersonal":clientesCapacitandos.CorreoPersonal,
//            "CorreoInstitucional":clientesCapacitandos.CorreoInstitucional,
//            "Sexo":clientesCapacitandos.Sexo,
//            "FechaAlta": formattedDate,
//            "TelefonoMovil":clientesCapacitandos.TelefonoMovil,
//            "TelefonoCasa":clientesCapacitandos.TelefonoCasa,
//            "IdCliente":clientesCapacitandos.IdCliente,
//            "IdTipoCapacitando":clientesCapacitandos.IdTipoCapacitando,
//            "IdEmpresa":clientesCapacitandos.IdEmpresa,
//            "IdModalidad":clientesCapacitandos.IdModalidad,
//            "FechaIngreso": formattedDate,
//            "FotoLink":clientesCapacitandos.FotoLink,
//            "UuidFirebase":clientesCapacitandos.UuidFirebase
//        ]
//        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted),
//               let jsonString = String(data: jsonData, encoding: .utf8) {
//                print("JSON a enviar:")
//                print(jsonString)
//            }
//
//        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
//            .validate()
//            .response { response in
//                switch response.result {
//                case .success:
//                    completion(.success(()))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
//
//    
//    func eliminarClientesCapacitandos(idClientesCapacitandos: String, completion: @escaping (Result<Void, Error>) -> Void) {
//           let url = webService.getBaseURL() + "/api/ClientesCapacitandos/\(idClientesCapacitandos)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
//           
//           AF.request(url, method: .delete)
//               .validate()
//               .response { response in
//                   switch response.result {
//                   case .success:
//                       completion(.success(()))
//                   case .failure(let error):
//                       completion(.failure(error))
//                   }
//               }
//       }
//
//        func fetchClientesCapacitandos(completion: @escaping (Result<[ClientesCapacitandos], Error>) -> Void) {
//            AF.request(webService.getBaseURL()+"/api/ClientesCapacitandos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
//                .validate()
//                .responseDecodable(of: [ClientesCapacitandos].self) { response in
//                    switch response.result {
//                    case .success(let clientesCapacitandos):
//                        completion(.success(clientesCapacitandos))
//                    case .failure(let error):
//                        completion(.failure(error))
//                    }
//                }
//        }
//    
//    func agregarClientesCapacitandos(nuevoClientesCapacitandos: ClientesCapacitandos, completion: @escaping (Result<ClientesCapacitandos, Error>) -> Void) {
//           let parameters: [String: Any] = [
//            "CURP": nuevoClientesCapacitandos.CURP,
//            "RenapoDatos":nuevoClientesCapacitandos.RenapoDatos,
//            "Nombre": nuevoClientesCapacitandos.Nombre,
//            "IdApellidoPaterno": nuevoClientesCapacitandos.IdApellidoPaterno,
//            "IdApellidoMaterno": nuevoClientesCapacitandos.IdApellidoMaterno,
//            "FechaNacimiento": nuevoClientesCapacitandos.FechaNacimiento,
//            "CalleNumero":nuevoClientesCapacitandos.CalleNumero,
//            "Colonia": nuevoClientesCapacitandos.Colonia,
//            "CodigoPostal": nuevoClientesCapacitandos.CodigoPostal,
//            "Localidad": nuevoClientesCapacitandos.Localidad,
//            "MunicipioResidencia":nuevoClientesCapacitandos.MunicipioResidencia,
//            "IdEstadoResidencia": nuevoClientesCapacitandos.IdEstadoResidencia,
//            "IdPaisNacimiento": nuevoClientesCapacitandos.IdPaisNacimiento,
//            "IdEstadoCivil": nuevoClientesCapacitandos.IdEstadoCivil,
//            "Escolaridad":nuevoClientesCapacitandos.Escolaridad,
//            "MotivoParaInscribirse": nuevoClientesCapacitandos.MotivoParaInscribirse,
//            "TrabajaActualmente": nuevoClientesCapacitandos.TrabajaActualmente,
//            "MotivoNoTrabaja": nuevoClientesCapacitandos.MotivoNoTrabaja,
//            "IdSucursal": nuevoClientesCapacitandos.IdSucursal,
//            "IdAlumno": nuevoClientesCapacitandos.IdAlumno,
//            "NumeroControl":nuevoClientesCapacitandos.NumeroControl,
//            "CorreoPersonal":nuevoClientesCapacitandos.CorreoPersonal,
//            "CorreoInstitucional":nuevoClientesCapacitandos.CorreoInstitucional,
//            "Sexo":nuevoClientesCapacitandos.Sexo,
//            "FechaAlta": nuevoClientesCapacitandos.FechaAlta,
//            "TelefonoMovil":nuevoClientesCapacitandos.TelefonoMovil,
//            "TelefonoCasa":nuevoClientesCapacitandos.TelefonoCasa,
//            "IdCliente":nuevoClientesCapacitandos.IdCliente,
//            "IdTipoCapacitando":nuevoClientesCapacitandos.IdTipoCapacitando,
//            "IdEmpresa":nuevoClientesCapacitandos.IdEmpresa,
//            "IdModalidad":nuevoClientesCapacitandos.IdModalidad,
//            "FechaIngreso": nuevoClientesCapacitandos.FechaIngreso,
//            "FotoLink":nuevoClientesCapacitandos.FotoLink,
//            "UuidFirebase":nuevoClientesCapacitandos.UuidFirebase
//           ]
//        
//           AF.request(webService.getBaseURL() + "/api/ClientesCapacitandos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
//               .validate()
//               .responseDecodable(of: ClientesCapacitandos.self) { response in
//                   switch response.result {
//                   case .success(let clientesCapacitandos):
//                       completion(.success(clientesCapacitandos))
//                   case .failure(let error):
//                       completion(.failure(error))
//                   }
//               }
//       }
//}
//
