import SwiftUI
import Foundation
import Alamofire

class UsuariosAPIService {
    
    private let baseURL = "http://webservices.iecapp.com"
    static let shared = UsuariosAPIService()
    
    func editarUsuario(usuario: Usuarios, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/ActualizarUsuario?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        print(url)
        let parameters: [String: Any] = [
            "Id": usuario.Id,
            "Nombre": usuario.Nombre,
            "ApellidoPaterno": usuario.ApellidoPaterno,
            "ApellidoMaterno": usuario.ApellidoMaterno,
            "FechaNacimiento": usuario.FechaNacimiento,
            "Numero": usuario.Numero,
            "TelefonoMovil": usuario.TelefonoMovil,
            "TelefonoFijo": usuario.TelefonoFijo,
            "CorreoInstitucional": usuario.CorreoInstitucional,
            "CorreoPersonal": usuario.CorreoPersonal,
            "IdSucursal": usuario.IdSucursal,
            "IdDepartamento": usuario.IdDepartamento,
            "IdPuesto": usuario.IdPuesto,
            "Estado": usuario.Estado,
            "FechaIngreso": usuario.FechaIngreso,
            "Estatus": usuario.Estatus,
            "Notas": usuario.Notas,
            "borrado": usuario.borrado,
            "FechaAlta": usuario.FechaAlta,
            "FotoLink": usuario.FotoLink,
            "IdFirebase": usuario.IdFirebase,
            "IdEmpresa": usuario.IdEmpresa
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
    
    func eliminarUsuario(idUsuario: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/Usuario/\(idUsuario)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
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
    
    func fetchUsuarios(completion: @escaping (Result<[Usuarios], Error>) -> Void) {
        AF.request(baseURL+"/ObtenerUsuarios?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
            .validate()
            .responseDecodable(of: [Usuarios].self) { response in
                switch response.result {
                case .success(let usuarios):
                    completion(.success(usuarios))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func agregarUsuario(usuario: Usuarios, completion: @escaping (Result<Usuarios, Error>) -> Void) {
        let parameters: [String: Any] = [
            "Id": usuario.Id,
            "Nombre": usuario.Nombre,
            "ApellidoPaterno": usuario.ApellidoPaterno,
            "ApellidoMaterno": usuario.ApellidoMaterno,
            "FechaNacimiento": usuario.FechaNacimiento,
            "Numero": usuario.Numero,
            "TelefonoMovil": usuario.TelefonoMovil,
            "TelefonoFijo": usuario.TelefonoFijo,
            "CorreoInstitucional": usuario.CorreoInstitucional,
            "CorreoPersonal": usuario.CorreoPersonal,
            "IdSucursal": usuario.IdSucursal,
            "IdDepartamento": usuario.IdDepartamento,
            "IdPuesto": usuario.IdPuesto,
            "Estado": usuario.Estado,
            "FechaIngreso": usuario.FechaIngreso,
            "Estatus": usuario.Estatus,
            "Notas": usuario.Notas,
            "borrado": usuario.borrado,
            "FechaAlta": usuario.FechaAlta,
            "FotoLink": usuario.FotoLink,
            "IdFirebase": usuario.IdFirebase,
            "IdEmpresa": usuario.IdEmpresa
            // Aquí van el resto de los campos de Usuario
        ]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print("JSON a enviar:")
            print(jsonString)
        }
        
        AF.request(baseURL + "/InsertarUsuario", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
            .validate()
            .responseDecodable(of: Usuarios.self) { response in
                switch response.result {
                case .success(let usuario):
                    completion(.success(usuario))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

