//
//  CursosBibliografia.swift
//  iecaappadmin
//
//  Created by Omar on 08/02/24.
//

import SwiftUI
import MobileCoreServices

struct CursosBibliografiaView: View {
    @State private var nombre = ""
    @State private var notas = ""
    @State private var autor = ""
    @State private var archivoSeleccionado: URL?
    @State private var showAlert = false
//    @ObservedObject var cursosBibliografiaViewModel: CursosBi
    var selectedCurso: Curso?
    
    var body: some View {
        
        TextField("Nombre", text: $nombre)
        TextField("Notas", text: $notas)
        TextField("Autor", text: $autor)
        
        if let archivo = archivoSeleccionado {
            Text("Archivo seleccionado: \(archivo.lastPathComponent)")
        } else {
            Button(action: {
            }) {
                Label("Cargar Archivo", systemImage: "doc")
            }
        }
        Button(action: {
//            agregarNuevaActividad()
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
    
//    private func agregarNuevaActividad() {
//        
//        guard let selectedCurso = selectedCurso else {
//            Alert(
//                title: Text("¡Error al agregar Actividad!"),
//                message: Text("Se obtiene un objeto vacio de la actividad"),
//                primaryButton: .default(Text("Aceptar")),
//                secondaryButton: .cancel(Text("Cancelar"))
//            )
//            return
//        }
//        
//        let idCurso = selectedCurso.Id
//        
//        let nuevoCursoActividad = CursosActividades(
//            Id : "00000000-0000-0000-0000-000000000000",
//            IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
//            Nombre : nombre,
//            Fecha: "2024-01-30T19:06:05.675Z",
//            Notas: notas,
//            Observaciones: observaciones,
//            IdCurso: idCurso,
//            IdActividad:"00000000-0000-0000-0000-000000000000",
//            Link:""
//        )
//        
//        cursosActividadesViewModel.agregarNuevoCurso(nuevoCurso: nuevoCursoActividad)
//        limpiarFormulario()
//        
//        
//    }
    
//    private func limpiarFormulario() {
//        // Restablecer los campos a sus valores iniciales
//        nombre = ""
//        notas = ""
//        observaciones = ""
//        archivoSeleccionado = nil
//    }

}
