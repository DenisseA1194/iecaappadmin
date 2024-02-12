//
//  CarouselBotones.swift
//  iecaappadmin
//
//  Created by Omar on 08/02/24.
//

import SwiftUI

struct CarouselView: View {
    let items: [String]
    @StateObject var cursosActividadesViewModel = CursosActividadesViewModel()

    @Binding var currentIndex: Int
    @State private var nombre: String = ""
    @State private var notas: String = ""
    @State private var observaciones: String = ""
    @State private var mostrarBloque = false
    @State private var nombreSeleccionado = ""
 
    var selectedCurso: Curso?
    
    
    var body: some View {
        
        if mostrarBloque {
            VStack{
                
                CursosActividadesView(cursosActividadesViewModel: cursosActividadesViewModel,selectedCurso: selectedCurso)

             
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

