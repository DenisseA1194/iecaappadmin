//
//  FormCursosActividades.swift
//  iecaappadmin
//
//  Created by Omar on 08/02/24.
//

import SwiftUI

import SwiftUI

struct CursosActividadesView: View {
    
    @State private var nombre = ""
    @State private var notas = ""
    @State private var observaciones = ""
    @State private var archivoSeleccionado: URL?
    @State private var showAlert = false
    @ObservedObject var cursosActividadesViewModel: CursosActividadesViewModel
    var selectedCurso: Curso?
    
    var body: some View {
        TextField("Nombre", text: $nombre)
        TextField("Notas", text: $notas)
        
        Text("Observaciones:")
            .font(.headline)
            .foregroundColor(.black)
        
        
        TextEditor(text: $observaciones)
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
            agregarNuevaActividad()
            showAlert.toggle()
            
            
            print("Botón Agregar presionado")
        }) {
            
            Text("Agregar Actividad")
                .font(.headline)
                .padding(8)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            
        }.alert(isPresented: $showAlert) {
            Alert(
                title: Text("Actividad agregada"),
                message: Text(""),
                primaryButton: .default(Text("Aceptar")),
                secondaryButton: .cancel(Text("Cancelar"))
            )
        }
    }
    
    private func agregarNuevaActividad() {
        
        guard let selectedCurso = selectedCurso else {
            Alert(
                title: Text("¡Error al agregar Actividad!"),
                message: Text("Se obtiene un objeto vacio de la actividad"),
                primaryButton: .default(Text("Aceptar")),
                secondaryButton: .cancel(Text("Cancelar"))
            )
            return
        }
        
        let idCurso = selectedCurso.Id
        
        let nuevoCursoActividad = CursosActividades(
            Id : "00000000-0000-0000-0000-000000000000",
            IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
            Nombre : nombre,
            Fecha: "2024-01-30T19:06:05.675Z",
            Notas: notas,
            Observaciones: observaciones,
            IdCurso: idCurso,
            IdActividad:"00000000-0000-0000-0000-000000000000",
            Link:""
        )
        
        cursosActividadesViewModel.agregarNuevoCurso(nuevoCurso: nuevoCursoActividad)
        limpiarFormulario()
        
        
    }
    
    private func limpiarFormulario() {
       
        nombre = ""
        notas = ""
        observaciones = ""
        archivoSeleccionado = nil
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CursosActividadesView()
//    }
//}
