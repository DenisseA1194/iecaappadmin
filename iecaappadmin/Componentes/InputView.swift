//
//  InputView.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 31/01/24.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12 ){
        Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            
            
            if isSecureField{
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
                   
                 
                   
            }else{
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            }
            Divider()
        }
        
    }
}


#Preview {
    InputView(text: .constant(""), title: "Correo electrónico", placeholder: "usuario@correo.com")
}
