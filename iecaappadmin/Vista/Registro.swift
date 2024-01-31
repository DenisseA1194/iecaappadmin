//
//  Registro.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 31/01/24.
//

import SwiftUI

struct Registro: View {
    
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    
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
                        
                        Task{
                            //                    try await viewModel.createUser(withEmail: email, password: password, fullname: fullname)
                        }
                        
                    }label: {
                        HStack{
                            Text("SOLICITUD DE REGISTRO")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width-32, height: 48)
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
