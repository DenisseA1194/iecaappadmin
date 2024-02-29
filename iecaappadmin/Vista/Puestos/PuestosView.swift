//
//  PuestosView.swift
//  iecaappadmin
//
//  Created by Omar on 26/02/24.
//

import SwiftUI

struct PuestosView: View {
    @Binding var presentSideMenu: Bool
    @Binding var showSignInView: Bool
    @State private var newRazonSocialName = ""
    @State private var newRepresentante = ""
    @State private var notas = ""
    @State private var regimenFiscal = RegimenFiscal.otro // Valor por defecto
    
    enum RegimenFiscal: String, CaseIterable, Identifiable {
        case regimen1 = "Puesto 1"
        case regimen2 = "Razon sociales 2"
        case regimen3 = "Razon sociales 3"
        case regimen4 = "Razon sociales 4"
        case regimen5 = "Razon sociales 5"
        case regimen6 = "Razon sociales 6"
        case otro = "Otro"
        
        var id: String { self.rawValue }
    }
    
    
    var body: some View {
//        HStack {
//            
//            Button(action: {
//                presentSideMenu.toggle()
//            }) {
//                Image("hamburguesa")
//                    .foregroundColor(.blue)
//                    .imageScale(.large)
//            }
//            .padding()
//            Spacer()
//        }
        NavigationView {
            Form {
                Section(header: Text("Selecciona un puesto")) {
                    Picker("Puestos", selection: $regimenFiscal) {
                        
                        ForEach(RegimenFiscal.allCases) { regimen in
                            Text(regimen.rawValue)
                        }
                    }.toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                
                            }) {
                                
                                Image(systemName: "plus")
                                
                            }
                        }
                    }
                }
                
                Section(header: Text("Nuevo puesto")) {
                    TextField("Nombre", text: $newRazonSocialName)
                    VStack(alignment: .leading) {
                        Text("Notas:") // Etiqueta para el TextEditor
                            .font(.headline)
                            .padding(.top)
                        
                        TextEditor(text: $notas)
                            .frame(minHeight: 200) // Altura mínima del TextEditor
                            .padding()
                            .background(Color.gray.opacity(0.1)) // Fondo del TextEditor
                            .cornerRadius(8) // Bordes redondeados
                            .padding()
                    }
                }
                HStack{
                    Spacer()
                    Image("logo") // Reemplaza "tu_imagen" con el nombre de tu imagen en el catálogo de activos
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(width: 200, height: 200) // Ajusta el tamaño según sea necesario
                               .clipShape(Circle()) // Opcional: recorta la imagen en forma de círculo
                               .overlay(Circle().stroke(Color.blue, lineWidth: 4)) // Opcional: agrega un borde alrededor de la imagen
                               .shadow(radius: 10)
                    Spacer()
                }
                
                Section {
                    Button("Guardar") {
                        
                    }
                }
            }
            .navigationTitle("Puestos")
            
        }
    }
}

//#Preview {
//    PuestosView()
//}
