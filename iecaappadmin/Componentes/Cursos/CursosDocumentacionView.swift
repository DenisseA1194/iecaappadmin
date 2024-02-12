//
//  CursosDocumentacion.swift
//  iecaappadmin
//
//  Created by Omar on 11/02/24.
//

import SwiftUI


import SwiftUI

struct CursosBiografiasView: View {
    
    @State private var nombre = ""
    @State private var notas = ""
    @State private var referencias = ""
    @State private var archivoSeleccionado: URL?
    @State private var showAlert = false
    @ObservedObject var cursosActividadesViewModel: CursosActividadesViewModel
    var selectedCurso: Curso?
    
    var body: some View {
        TextField("Nombre", text: $nombre)
        TextField("Notas", text: $notas)
        
        Text("Referencias:")
            .font(.headline)
            .foregroundColor(.black)
        
        
        TextEditor(text: $referencias)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 200)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            .border(Color.gray, width: 1)
        
        if let archivo = archivoSeleccionado {
            Text("Archivo seleccionado: \(archivo.lastPathComponent)")
        } else {
            Button(action: {
            }) {
                Label("Cargar Archivo", systemImage: "doc")
            }
        }
        Button(action: {
            agregarNuevaDocumentacion()
            showAlert.toggle()
            
        }) {
            
            Text("Agregar Documentacion")
                .font(.headline)
                .padding(8)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            
        }.alert(isPresented: $showAlert) {
            Alert(
                title: Text("Documentacion agregada"),
                message: Text(""),
                primaryButton: .default(Text("Aceptar")),
                secondaryButton: .cancel(Text("Cancelar"))
            )
        }
    }
    
    private func agregarNuevaDocumentacion() {
        
        guard let selectedCurso = selectedCurso else {
            Alert(
                title: Text("¡Error al agregar Documentacion!"),
                message: Text("Se obtiene un objeto vacio de la Documentacion"),
                primaryButton: .default(Text("Aceptar")),
                secondaryButton: .cancel(Text("Cancelar"))
            )
            return
        }
        
        let idCurso = selectedCurso.Id
        
        let nuevoCursoDocumentacion = CursosDocumentacion(
            Id : "00000000-0000-0000-0000-000000000000",
            IdCurso: idCurso,
            IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
            Nombre : nombre,
            Fecha: "2024-01-30T19:06:05.675Z",
            LinkDocumento: "",
            Notas: notas,
            Referencias: referencias
         
        )
        
//        cursosActividadesViewModel.agregarNuevoCurso(nuevoCurso: nuevoCursoActividad)
        limpiarFormulario()
        
        
    }
    
    private func limpiarFormulario() {
        // Restablecer los campos a sus valores iniciales
        nombre = ""
        notas = ""
        referencias = ""
        archivoSeleccionado = nil
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CursosActividadesView()
//    }
//}

