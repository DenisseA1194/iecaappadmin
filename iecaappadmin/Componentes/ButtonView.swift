//
//  ButtonView.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 31/01/24.
//

import SwiftUI

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(.top, 24)
            .background(Color(.azulMarino))
            .cornerRadius(10)
    }
}


