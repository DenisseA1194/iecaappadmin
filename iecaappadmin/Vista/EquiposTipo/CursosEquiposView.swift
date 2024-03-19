//
//  CursosEquiposView.swift
//  iecaappadmin
//
//  Created by Omar on 19/03/24.
//

import SwiftUI

struct CursosEquiposView: View {
    // Variables para los pickers y los campos de texto
        @State private var selectedCurso = 0
        @State private var selectedTipoEquipo = 0
        @State private var selectedEquipo = 0
        @State private var link = ""
        @State private var notaBajo = ""
        
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
                    
                    Section(header: Text("Selecciona Tipo de Equipo")) {
                        Picker("Tipo de Equipo", selection: $selectedTipoEquipo) {
                            Text("Tipo 1").tag(0)
                            Text("Tipo 2").tag(1)
                            Text("Tipo 3").tag(2)
                        }
                    }
                    
                    Section(header: Text("Selecciona Equipo")) {
                        Picker("Equipo", selection: $selectedEquipo) {
                            Text("Equipo 1").tag(0)
                            Text("Equipo 2").tag(1)
                            Text("Equipo 3").tag(2)
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
                    
                    Section(header: Text("Nota de Bajo")) {
                        TextField("Nota de Bajo", text: $notaBajo)
                    }
                }
                .navigationTitle("Equipos de Cursos")
            }
        }
}

#Preview {
    CursosEquiposView()
}
