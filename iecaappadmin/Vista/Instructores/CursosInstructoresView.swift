//
//  CursosInstructoresView.swift
//  iecaappadmin
//
//  Created by Omar on 19/03/24.
//

import SwiftUI

struct CursosInstructoresView: View {
    // Variables para los pickers y el campo de notas
       @State private var selectedCurso = 0
       @State private var selectedInstructor = 0
       @State private var notas = ""
       
       var body: some View {
           NavigationView {
               Form {
                   Section(header: Text("Selecciona un Curso")) {
                       Picker("Curso", selection: $selectedCurso) {
                           Text("Curso 1").tag(0)
                           Text("Curso 2").tag(1)
                           Text("Curso 3").tag(2)
                       }
                   }
                   
                   Section(header: Text("Selecciona un Instructor")) {
                       Picker("Instructor", selection: $selectedInstructor) {
                           Text("Instructor 1").tag(0)
                           Text("Instructor 2").tag(1)
                           Text("Instructor 3").tag(2)
                       }
                   }
                   
                   Section(header: Text("Notas")) {
                       TextField("Notas", text: $notas)
                   }
               }
               .navigationTitle("Instructores de Cursos")
           }
       }
}

#Preview {
    CursosInstructoresView()
}
