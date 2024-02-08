//
//  Login.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 31/01/24.
//

import SwiftUI

struct Login: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var newPassword = ""
    @State var isLoading: Bool = false
    @State var isPresented: Bool = false
    @State private var checked = true
    @State private var showSignInView: Bool = false
    
    //  @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
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
                    NavigationLink(
                        destination: CursosView(showSignInView: $showSignInView),
                        isActive: $showSignInView
                    ) {
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
                    }
                    .padding(.horizontal)
                    .padding(.vertical)
                    .padding(.top, 12)
                    .background(Color.white)
                    .cornerRadius(15)
                    
                    
                    
                    Spacer()
                    
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
                    .padding(.top, 24)
                    
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
                    .padding(.top, 24)
                    .alert("Recupera contraseña", isPresented: $isPresented, actions: {
                        SecureField("Contraseña", text: $newPassword)
                        
                        
                        Button("Cancelar", role: .cancel, action: {})
                        Button("Guardar", action: {})
                        
                    }, message: {
                        Text("Ingresa tu nueva contraseña")
                    })
                    
                }
                .background(Color(.colorFondo))
                
                
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
}
