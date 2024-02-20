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
struct Registro: View {
    
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showAlert = false
    @State private var showAlertCorreo = false
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
                        Task {
                            do {
                                try await sigUp(email: self.email, password: self.password)
                                self.showAlertCorreo = true
                                return
                            }catch{
                                print(error)
                            }
                        }
                        //
                    } else {
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
                    Alert(title: Text("Error"), message: Text("Las contraseñas no coinciden"), dismissButton: .default(Text("OK")))
                } .alert(isPresented: $showAlertCorreo) {
                    Alert(title: Text("Correo de Confirmación Enviado"), message: Text("Se ha enviado un correo de confirmacion a tu correo electronico"), dismissButton: .default(Text("OK")) {
                        hideKeyboard()
                        self.presentationMode.wrappedValue.dismiss()
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
