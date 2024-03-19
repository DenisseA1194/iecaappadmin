//
//  CursosBibliografia.swift
//  iecaappadmin
//
//  Created by Omar on 19/03/24.
//

import SwiftUI

struct CursosBibliografiasView: View {
    // Variables para los pickers
      @State private var selectedCurso = 0
      @State private var selectedBibliografia = 0
      
      // Variables para los campos de texto
      @State private var titulo = ""
      @State private var autor = ""
      @State private var link = ""
      @State private var notas = ""
      
      // Función para agregar
      func agregar() {
          // Aquí implementa la lógica para agregar los datos
      }
      
      var body: some View {
          NavigationView {
              Form {
                  Section(header: Text("Seleccione Curso")) {
                      Picker("Curso", selection: $selectedCurso) {
                          Text("Curso 1").tag(0)
                          Text("Curso 2").tag(1)
                          Text("Curso 3").tag(2)
                      }
                  }
                  
                  Section(header: Text("Seleccione Bibliografía")) {
                      Picker("Bibliografía", selection: $selectedBibliografia) {
                          Text("Bibliografía 1").tag(0)
                          Text("Bibliografía 2").tag(1)
                          Text("Bibliografía 3").tag(2)
                      }
                  }
                  
                  Section(header: Text("Información del Libro")) {
                      TextField("Título", text: $titulo)
                      TextField("Autor", text: $autor)
                      TextField("Link", text: $link)
                  }
                  
                  Section(header: Text("Agregar")) {
                      Button("Agregar") {
                          agregar()
                      }
                      .frame(maxWidth: .infinity)
                      .padding()
                      .background(Color.blue)
                      .foregroundColor(.white)
                      .cornerRadius(8)
                  }
                  
                  Section(header: Text("Notas")) {
                      TextEditor(text: $notas)
                          .frame(minHeight: 100)
                  }
              }
              .navigationTitle("Bibliografia")
          }
      }
}

#Preview {
    CursosBibliografiasView()
}
