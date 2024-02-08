//
//  CarouselBotones.swift
//  iecaappadmin
//
//  Created by Omar on 08/02/24.
//

import SwiftUI

struct CarouselView: View {
    let items: [String]
   
    @Binding var currentIndex: Int
    @State private var nombre: String = ""
    @State private var notas: String = ""
    @State private var mostrarBloque = false
    @State private var nombreSeleccionado = ""
 
    var selectedCurso: Curso?
    
    
    var body: some View {
        
        if mostrarBloque {
            VStack{
                TextField("Nombre",text: $nombre)
                TextField("Notas",text: $notas)
                Button(action: {
                    // Acción que se ejecutará cuando se presione el botón
                    // Aquí puedes agregar la lógica para agregar algo
                    print("Botón Agregar presionado")
                }) {
                    
                    Text("Agregar " + nombreSeleccionado)
                        .font(.headline)
                        .padding(8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    
                }
            }
            Text(" ")
            
            
        }
        
        ScrollView(.horizontal) {
            
            HStack {
                ForEach(0..<items.count) { index in
                    let item = items[index]
                    
                    if item != "" {
                        Button(action: {
                            // Acción a realizar cuando se presiona el botón
                            nombreSeleccionado = item
                            currentIndex = index
                            mostrarBloque = true
                        }) {
                            Text("\(item)")
                                .foregroundColor(.white)
                                .padding()
                                .background(index == currentIndex ? Color.green : Color.blue)
                                .cornerRadius(8)
                        }
                    }
                    
                }
            }
            .padding(.bottom)
        }
    
        
    }
}

