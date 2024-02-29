//
//  Registro.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 31/01/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase


extension Usuario {
    // Convierte el objeto Usuario a un diccionario Any para ser guardado en Firebase
    func toAnyObject() -> Any {
        return [
            "uid": uid,
            "correo": correo,
            "nombre": nombre,
            "empresa": empresa,
            "status": status,
            "cliente": cliente,
            "fechahora": fechahora
        ]
    }
}

struct Usuario {
    var uid: String
    var correo: String
    var nombre: String
    var empresa: String
    var status: Bool
    var cliente: Bool
    var fechahora: String
}


extension String {
    // Esta función verifica si la contraseña cumple con los requisitos mínimos y devuelve un mensaje indicando los requisitos que faltan
    func isValidPassword() -> (isValid: Bool, message: String) {
        // Verificar la longitud mínima
        if self.count < 8 {
            return (false, "La contraseña debe tener al menos 8 caracteres")
        }
        
        // Verificar si contiene al menos una letra minúscula
        let lowercaseLetterRegEx  = ".*[a-z]+.*"
        let lowercaseTest = NSPredicate(format:"SELF MATCHES %@", lowercaseLetterRegEx)
        if !lowercaseTest.evaluate(with: self) {
            return (false, "La contraseña debe contener al menos una letra minúscula")
        }
        
        // Verificar si contiene al menos una letra mayúscula
        let uppercaseLetterRegEx  = ".*[A-Z]+.*"
        let uppercaseTest = NSPredicate(format:"SELF MATCHES %@", uppercaseLetterRegEx)
        if !uppercaseTest.evaluate(with: self) {
            return (false, "La contraseña debe contener al menos una letra mayúscula")
        }
        
        // Verificar si contiene al menos un dígito
        let digitRegEx  = ".*[0-9]+.*"
        let digitTest = NSPredicate(format:"SELF MATCHES %@", digitRegEx)
        if !digitTest.evaluate(with: self) {
            return (false, "La contraseña debe contener al menos un número")
        }
        
        // Verificar si contiene al menos un carácter especial
        let specialCharacterRegEx  = ".*[^A-Za-z0-9]+.*"
        let specialCharacterTest = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        if !specialCharacterTest.evaluate(with: self) {
            return (false, "La contraseña debe contener al menos un carácter especial")
        }
        
        // Si pasa todas las verificaciones, la contraseña es válida
        return (true, "La contraseña es válida")
    }
}

struct Registro: View {
    
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showAlertError = false
    @State private var showAlertPasswordInseguro = false
    @State private var showAlertCorreo = false
    @State private var mensajePasswordInsegura = ""
    @State private var mensajeUsuario = ""
    @State private var mensajeAlerta = ""
    @State private var tituloAlerta = ""
    @State private var showAlert = false
    @State private var isBackToLogin = false
    @State private var showAlertUserExists = false
    @State private var showAlertUsuarioAgregado = false
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    //    @StateObject private var viewModel = AuthenticationViewModel()
    
    
    
    
    func sigUp(email:String, password: String) async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        try await AuthenticationManager.shared.createUser(email: email, password: password, fullname: fullname)
        
        
    }
    
    
    var body: some View {
        VStack{
            //Logo
            Image("IECA_azul")
            //.renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .padding(.vertical, 32)
            //  .foregroundColor(.white)
            
            Text("Registro exclusivo colaboradores IECA®")
                .font(.headline)
                .foregroundColor(.azulMarino)
            
            
            VStack(alignment: .center, spacing: 24){
                
                HStack {
                    Image(systemName: "person.crop.square.fill")
                        .foregroundColor(.azulMarino)
                        .padding(.horizontal,10)
                    
                    InputView(text: $fullname, title: "Nombre completo", placeholder: "Nombre(s) Apellidos(s)")
                        .padding(8)
                }
                .background(Color(.colorFondo))
                .cornerRadius(5)
                
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.azulMarino)
                        .padding(.horizontal,10)
                    
                    InputView(text: $email, title: "Correo electrónico", placeholder: "Correo electrónico IECA")
                        .padding(8)
                }
                .background(Color(.colorFondo))
                .cornerRadius(5)
                
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.azulMarino)
                        .padding(.horizontal,10)
                    
                    InputView(text: $password, title: "Contraseña", placeholder: "Ingrese su contraseña", isSecureField: true)
                        .padding(8)
                }
                .background(Color(.colorFondo))
                .cornerRadius(5)
                
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.azulMarino)
                        .padding(.horizontal,10)
                    
                    InputView(text: $confirmPassword, title: "Confirmar contraseña", placeholder: "Confirma tu contraseña", isSecureField: true)
                        .padding(8)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty{
                        
                        if password == confirmPassword{
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                            
                        }else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                            
                        }
                    }
                }
                .background(Color(.colorFondo))
                .cornerRadius(5)
                //Guardar registro
                Button{
                    
                    if self.password == self.confirmPassword {
                        if password.isValidPassword().isValid {
                            Task {
                                do {
                                    let isUserExists = try await AuthenticationManager.shared.checkIfUserExists(email: self.email, password: self.password)
                                    if isUserExists {
                                        self.isBackToLogin = true
                                        self.mensajeAlerta = "El usuario ya existe. Por favor, inicia sesión."
                                        self.tituloAlerta = "Usuario ya registrado"
                                        self.showAlert = true
                                        return
                                    }
                                    else{
                                        
                                        try await sigUp(email: self.email, password: self.password)
                                        self.isBackToLogin = true
                                        self.mensajeAlerta = "Se envio un email de confirmacion al correo "+email
                                        self.tituloAlerta = "Se ha registrado el usuario"
                                        self.showAlert = true
                                        
                                    }
                                } catch {
                                    
                                    print(error)
                                    //                                    showAlertError = true
                                    self.mensajeAlerta = "El usuario ya esta registrado"
                                    self.tituloAlerta = "Error"
                                    self.showAlert = true
                                    
                                }
                            }
                        } else {
                            tituloAlerta = "Contrasena insegura"
                            self.mensajeAlerta = password.isValidPassword().message
                            self.showAlert = true
                        }
                    } else {
                        tituloAlerta = "Error"
                        self.mensajeAlerta = "La contrasena no coincide"
                        self.showAlert = true
                    }
                }label: {
                    HStack{
                        Text("SOLICITUD DE REGISTRO")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width-32, height: 48)
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text(tituloAlerta), message: Text(mensajeAlerta), dismissButton: .default(Text("OK")){
                        
                        if isBackToLogin {
                            hideKeyboard()
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        
                    })
                }
                .background(Color(.azulMarino))
                //            .disabled(!formIsValid)
                //            .opacity(formIsValid ? 1.0 : 5.0)
                .cornerRadius(10)
                .padding(.top, 24)
                
            }
            .padding(.horizontal)
            .padding(.vertical)
            .padding(.top,12)
            .background(Color(.white))
            .cornerRadius(15)
            
            
            
            
            //aqui termina formulario
            
            Spacer()
            
            Button{
                dismiss()
                
            }label: {
                HStack(spacing: 3){
                    Text("¿Ya tienes una cuenta?")
                        .foregroundColor(Color(.azulMarino))
                    Text("Iniciar")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color(.azulMarino))
                }
                .font(.system(size: 14))
            }
        }
        .background(Color(.colorFondo))
        
    }
}

func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}

//extension RegistrationView: AuthenticationFormProtocol {
//    var formIsValid: Bool {
//        return  !email.isEmpty
//        && email.contains("@")
//        && !password.isEmpty
//        && password.count > 5
//        && confirmPassword == password
//        && !fullname.isEmpty
//    }
//}
#Preview {
    Registro()
}
