//
//  CursosDocumentacionView.swift
//  iecaappadmin
//
//  Created by Omar on 19/03/24.
//

import SwiftUI

struct CursosDocView: View {
    // Variables para el picker y el campo de notas
       @State private var selectedCurso = 0
       @State private var link = ""
       @State private var notas = ""
       
       var body: some View {
           NavigationView {
               Form {
                   Section(header: Text("Selecciona Curso")) {
                       Picker("Curso", selection: $selectedCurso) {
                           Text("Curso 1").tag(0)
                           Text("Curso 2").tag(1)
                           Text("Curso 3").tag(2)
                       }
                   }
                   
                   Section(header: Text("Link")) {
                       TextField("Link", text: $link)
                   }
                   
                   Section {
                       HStack {
                           Spacer()
                           Button(action: {
                               // Acción para el botón "Agregar"
                           }) {
                               Text("Agregar")
                           }
                           Spacer()
                       }
                   }
                   
                   Section(header: Text("Notas")) {
                       TextEditor(text: $notas)
                           .frame(minHeight: 100)
                   }
               }
               .navigationTitle("Documentación de Cursos")
           }
       }
}

//#Preview {
//    CursosDocumentacionView()
//}
