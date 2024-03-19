//
//  SectorTipoCliente.swift
//  iecaappadmin
//
//  Created by Omar on 19/03/24.
//

import SwiftUI

struct SectorTipoCliente: View {
    // Variables para los pickers y el campo de notas
       @State private var selectedCurso = 0
       @State private var selectedTipoCliente = 0
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
                   
                   Section(header: Text("Selecciona un Tipo de Cliente")) {
                       Picker("Tipo de Cliente", selection: $selectedTipoCliente) {
                           Text("Tipo 1").tag(0)
                           Text("Tipo 2").tag(1)
                           Text("Tipo 3").tag(2)
                       }
                   }
                   
                   Section(header: Text("Notas")) {
                       TextField("Notas", text: $notas)
                   }
               }
               .navigationTitle("Sector Tipo Cliente")
           }
       }
}

#Preview {
    SectorTipoCliente()
}
