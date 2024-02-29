//
//  AuthenticationManager.swift
//  iecaappadmin
//
//  Created by Omar on 15/02/24.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

struct AuthDataResultModel{
    
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthenticationManager {
    let ref = Database.database().reference()
    let webService = WebService()
    static let shared = AuthenticationManager()
    private init(){ }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
   
    func signOut() throws{
       try Auth.auth().signOut()
    }
}


extension AuthenticationManager {
    
    func formattedDate() -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
           return dateFormatter.string(from: Date())
       }
    
    func agregarBD(email: String, fullname: String, uid: String) {
           let uidFirebase = uid
           
           let user = Usuario(uid: uidFirebase,
                              correo: email,
                              nombre: fullname,
                              empresa: "A9AD6F66-FA94-450A-BC94-5B8CC8CAB08B",
                              status: false,
                              cliente: false,
                              fechahora: formattedDate())
           
           ref.child("Usuarios").child(user.uid).setValue(user.toAnyObject())
           
       
       }
    
    func checkIfUserExists(email: String, password: String) async throws -> Bool {
            
            do {
                _ = try await Auth.auth().signIn(withEmail: email, password: password)
                return true
            } catch {
                return false
            }
        }
    
    @discardableResult
    func createUser(email: String, password: String, fullname: String) async throws -> AuthDataResultModel{
        var authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let actionCodeSettings = ActionCodeSettings()  // Definir actionCodeSettings
        actionCodeSettings.url = URL(string: "https://iecapp2-default-rtdb.firebaseio.com") // Cambia por tu dominio dinámico
              actionCodeSettings.handleCodeInApp = true
        
        if let user = Auth.auth().currentUser {
               let email_user = user.email
               let uid_user =  authDataResult.user.uid
               
               // Enviar correo de verificación
               user.sendEmailVerification { error in
                   if let error = error {
                       print("Error al enviar correo de verificación: \(error.localizedDescription)")
                       return
                   }
                   print("Correo de verificación enviado a: \(email ?? "")")
                   self.agregarBD(email: email, fullname: fullname, uid: uid_user)
                   
                   // Agregar lógica adicional después de enviar el correo de verificación
                   // Por ejemplo, puedes mostrar una alerta o realizar otras acciones.
               }
           }
        
        
//        Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings) { error in
//            if let error = error {
//                // Manejar el error si ocurrió algún problema durante el envío del enlace
//                print("Error al enviar el enlace de inicio de sesión:", error)
//                //                        self.showAlert = true
//                return
//            }
//        }

       return AuthDataResultModel(user: authDataResult.user)
    }
    
//    @discardableResult
//    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
//        let authDataResult = try await Auth.auth().signIn(withEmail: email, link: password)
////        if let user = Auth.auth().currentUser {
////            if user.isEmailVerified {
////               print("Perfil verificado")
////            } else {
////              print("Perfil no verificado ")
////            }
////        }
////       
//        
//        return AuthDataResultModel(user: authDataResult.user)
//    }
    
//    @discardableResult
//    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
//        // Verificar si el enlace es válido para el inicio de sesión con correo electrónico y enlace
//        if Auth.auth().isSignIn(withEmailLink: password) {
//            // El enlace es válido, procede con el inicio de sesión con correo electrónico y enlace
//            let authDataResult = try await Auth.auth().signIn(withEmail: email, link: password)
//            return AuthDataResultModel(user: authDataResult.user)
//        } else {
//            // El enlace no es válido para el inicio de sesión con correo electrónico y enlace
//            // Realiza las acciones necesarias, como mostrar un mensaje de error al usuario
//            print("El enlace proporcionado no es válido para el inicio de sesión con correo electrónico y enlace.")
//            // Lanza una excepción o maneja el error de otra manera según tus necesidades
//            throw NSError(domain: "InvalidEmailLink", code: 0, userInfo: nil)
//        }
//    }
    
    @discardableResult
//    func signInUser(email: String, password: String) async throws -> AuthDataResultModel? {
    func signInUser(email: String, password: String) async throws -> String? {
        do {
            let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
            
            var respuesta = ""
            
            
            // Verificar si el correo electrónico del usuario está verificado
            let isEmailVerified = authDataResult.user.isEmailVerified
            var uid = authDataResult.user.uid
            // Aquí puedes realizar acciones basadas en si el correo electrónico está verificado o no
            if isEmailVerified {
                print("El correo electrónico del usuario está verificado")
                respuesta = "El correo electrónico del usuario está verificado"
            
                print("este es el uid:  "+uid)
                getIdEmpresa(uid: uid)
     
                
            } else {
                print("El correo electrónico del usuario no está verificado")
                respuesta = "El correo electrónico del usuario no está verificado"
            }
            
   
            return respuesta
        } catch {
            
            print("Error al iniciar sesión:", error.localizedDescription)
            return "El usuario con el que intenta ingresar no ha sido registrado"
        }
    }
    
    func getCadena(idEmpresa: String){
        print("este es el id de la empresa alv:", idEmpresa)
        let ref = Database.database().reference().child("Conexiones").child(idEmpresa).child("Cadena")

        
          ref.observe(.value) { snapshot in
              guard let cadena = snapshot.value as? String else {
                  print("No se pudo obtener la cadena de la base de datos")
                  return
              }
              let webService = WebService()
             
              webService.setBaseURL(cadena)
              print("URL base actualizada:", cadena)
          }
    }
    
    func getIdEmpresa(uid: String) {
        let ref = Database.database().reference().child("Usuarios").child(uid).child("empresa")
            
            ref.observeSingleEvent(of: .value) { snapshot in
                guard let id = snapshot.value as? String else {
                    print("No se pudo obtener la empresa de la base de datos")
                    return
                }
                
                // Aquí tienes el valor de la empresa, ahora puedes hacer lo que necesites con él
                print("ID de empresa:", id)
                self.getCadena(idEmpresa: id)
                // Por ejemplo, puedes llamar a otro método y pasarle el valor
//                self.otroMetodo(idEmpresa: id)
            }
    }
   
    func resetPassword(email: String) async throws{
       try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
            
        }
            
       try await user.updatePassword(to: password)
    }
    
    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
            
        }
        
       try await user.updateEmail(to: email)
    }
    
}

//extension AuthenticationManager {
//    
//    @discardableResult
//    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel{
//        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
//        return try await signIn(credential: credential)
//    }
//    
//    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel{
//       
//        let authDataResult = try await Auth.auth().signIn(with: credential)
//        
//        return AuthDataResultModel(user: authDataResult.user)
//    }
//}
