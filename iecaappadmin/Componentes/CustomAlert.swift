//
//  AlertView.swift
//  iecaappadmin
//
//  Created by Omar on 16/02/24.
//

import SwiftUI

class CustomAlert: ObservableObject {
    @Published var isPresented = false
    var title: String
    var message: String

    init(title: String, message: String) {
        self.title = title
        self.message = message
    }

    func showAlert() {
        isPresented = true
    }

    func dismissAlert() {
        isPresented = false
    }
}

struct Content: View {
    @StateObject var customAlert = CustomAlert(title: "Título de la Alerta", message: "Mensaje de la Alerta")

    var body: some View {
        VStack {
            Button("Mostrar Alerta") {
                customAlert.showAlert()
            }
        }
        .alert(isPresented: $customAlert.isPresented) {
            Alert(
                title: Text(customAlert.title),
                message: Text(customAlert.message),
                dismissButton: .default(Text("OK")) {
                    customAlert.dismissAlert()
                }
            )
        }
    }
}
