//
//  Login.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 31/01/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
}

final class SignInEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func sigUp() async throws {
        //        guard !email.isEmpty, !password.isEmpty else{
        //            print("No email or password found")
        //            return
        //        }
        
        //        try await AuthenticationManager.shared.createUser(email: "omarcampos2596@gmail.com", password: "12345678")
        
    }
    
    func sigIn() async throws {
        guard !email.isEmpty, !password.isEmpty else{
            print("No email or password found")
            return
        }
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
        
    }
    
}

//@MainActor
//final class AuthenticationViewModel: ObservableObject {
//
//    func signInGoogle() async throws{
//
//        guard let topVC = Utilities.shared.topViewController() else {
//            throw URLError(.cannotFindHost)
//        }
//
//        let gidSingInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
//
//        guard let idToken = gidSingInResult.user.idToken?.tokenString else {
//            throw URLError(.badServerResponse)
//        }
//
//        let accessToken = gidSingInResult.user.accessToken.tokenString
//
//        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
//        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
//
//    }
//
//}

struct Login: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    //    @Binding var showSignInView: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var newPassword = ""
    @State var isLoading: Bool = false
    @State var isPresented: Bool = false
    @State var respuestaCorreo: String = ""
    @State private var checked = true
    @State private var showSignInView: Bool = false
    @State private var showMainTabbedView = false
    @State private var showAlertCorreo = false
    
    //  @EnvironmentObject var viewModel: AuthViewModel
    
    func sigUp() async throws {
        guard !email.isEmpty, !password.isEmpty else{
            print("No email or password found")
            return
        }
        
        //        try await AuthenticationManager.shared.createUser(email: email, password: password)
        
    }
    
    
    func sigIn(correo: String, contrasena: String) async throws -> String{
        guard !correo.isEmpty, !contrasena.isEmpty else{
            print("No email or password found")
            return "No email or password found"
        }
        
        print(correo," "+contrasena)
        var respuesta = ""
        
        respuesta = try await AuthenticationManager.shared.signInUser(email: correo, password: contrasena)!
        
        
        return respuesta
        
    }
    
    
    
    var body: some View {
        if showMainTabbedView {
            MainTabbedView()
                .transition(.slide)
        } else {
            NavigationStack{
                
                VStack{
                    //Logo
                    Image("IECA_azul")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 120)
                        .padding(.vertical, 32)
                    
                    Text("Aplicación de uso interno")
                        .font(.headline)
                        .foregroundColor(.azulMarino)
                    
                    //Formulario
                    VStack(spacing: 24){
                        
                        HStack{
                            InputView(text: $email, title: "Correo registrado", placeholder: "Correo electrónico IECA")
                                .padding(8)
                            
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.azulMarino)
                                .padding(.horizontal,10)
                        }
                        .background(Color(.colorFondo))
                        .cornerRadius(5)
                        
                        
                        HStack{
                            InputView(text: $password, title: "Contraseña", placeholder: "Ingresa tu contraseña", isSecureField: true)
                                .padding(8)
                            
                            Image(systemName: "lock.fill")
                                .foregroundColor(.azulMarino)
                                .padding(.horizontal,10)
                        }
                        .background(Color(.colorFondo))
                        .cornerRadius(5)
                        
                        HStack {
                            Text("Recordarme")
                                .font(.system(size: 14))
                            CheckBoxView(checked: $checked)
                            Spacer()
                            
                        }
                        if isLoading {
                            ProgressView()
                                .scaleEffect(2)
                        }
                        
                        //Inicio sesión
                        Button {
                           
                            Task {
                                do {
                                   respuestaCorreo = try await sigIn(correo: email, contrasena: password)
                                    if respuestaCorreo == "El correo electrónico del usuario no está verificado" || respuestaCorreo == "No email or password found" {
                                        showAlertCorreo = true
                                    }else{
                                        showMainTabbedView = true
                                        showSignInView = true
                                    }
                                    showSignInView = false
                                    return
                                }catch{
                                    print(error)
                                }
                
                            }
                            
                        } label: {
                            HStack {
                                Text("ENTRAR")
                                    .fontWeight(.semibold)
                                Image(systemName: "arrow.right")
                            }
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width-32, height: 48)
                            .background(Color(.azulMarino))
                            .cornerRadius(10)
                            .padding(.top, 24)
                        }.alert(isPresented: $showAlertCorreo) {
                            Alert(title: Text("Problam al iniciar sesion"), message: Text(respuestaCorreo), dismissButton: .default(Text("OK")) {
                                
                            })
                        }
                        .padding(.horizontal)
                        .padding(.vertical)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        
                        //Abrir Registro
                        NavigationLink{
                            Registro()
                                .navigationBarBackButtonHidden(true)
                        }label: {
                            HStack(spacing: 3){
                                Text("Registro nuevo usuario")
                            }
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                            .frame(width: UIScreen.main.bounds.width-32, height: 48)
                            
                        }
                        .background(Color(.white))
                        .cornerRadius(10)
                        
                        
                        //Recuperar contraseña
                        Button{
                            
                            isPresented = true
                            
                        }label: {
                            HStack(spacing: 3){
                                Text("Recuperar contraseña")
                            }
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                            .frame(width: UIScreen.main.bounds.width-32, height: 48)
                            
                        }
                        .background(Color(.white))
                        .cornerRadius(10)
                        
                        .alert("Recupera contraseña", isPresented: $isPresented, actions: {
                            SecureField("Contraseña", text: $newPassword)
                            
                            
                            Button("Cancelar", role: .cancel, action: {})
                            Button("Guardar", action: {})
                            
                        }, message: {
                            Text("Ingresa tu nueva contraseña")
                        })
                        
                    }.padding()
                        .background(Color(.colorFondo))
                    
                    
                }
            }
        }
    }
    
}

//extension LoginView: AuthenticationFormProtocol {
//    var formIsValid: Bool {
//        return  !email.isEmpty
//        && email.contains("@")
//        && !password.isEmpty
//        && password.count > 5
//    }
//}

//#Preview {
//    Login()
//}

