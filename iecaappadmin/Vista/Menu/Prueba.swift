////
////  SlideMenu.swift
////  iecaappadmin
////
////  Created by Omar on 12/02/24.
////
//
//import SwiftUI
//import SwiftUI
//
//struct MenuItem: Identifiable {
//    let id = UUID()
//    let title: String
//    var children: [MenuItem]?
//        var isOpen: Bool = false
//}
//
//struct SectionHeader: View {
//    var title: String
//    
//    var body: some View {
//        Text(title)
//            .font(.headline)
//            .foregroundColor(.gray)
//            .padding(.vertical, 8)
//            .padding(.horizontal, 16)
//    }
//}
//
//struct MainTabbedView: View {
//    
//    @State var menuItems: [MenuItem] = [
//           MenuItem(title: "Dashboard", children: nil),
//           MenuItem(title: "Cursos", children: [
//               MenuItem(title: "Modalidad", children: nil),
//               MenuItem(title: "Tipo confidencialidad", children: nil),
//               MenuItem(title: "Campo formacion", children: nil),
//               MenuItem(title: "Area", children: nil),
//               MenuItem(title: "Especialidades", children: nil)
//           ]),
//           MenuItem(title: "Plataforma", children: [
//               MenuItem(title: "Tipo sucursal", children: nil),
//               MenuItem(title: "Institucion", children: nil),
//               MenuItem(title: "actividades", children: nil),
//               MenuItem(title: "competencias", children: nil),
//               MenuItem(title: "materiales", children: nil),
//               MenuItem(title: "programas", children: nil),
//               MenuItem(title: "temas", children: nil),
//               MenuItem(title: "Razon social", children: nil),
//               MenuItem(title: "Zona", children: nil),
//               MenuItem(title: "Puestos", children: nil),
//               MenuItem(title: "Departamentos", children: nil),
//               MenuItem(title: "Sucursales", children: nil)
//           ])
//    ]
//    
//    var body: some View {
//        HStack {
//            ZStack{
//                Rectangle()
//                    .fill(.white)
//                    .frame(width: 270)
//                    .shadow(color: .purple.opacity(0.1), radius: 5, x: 0, y: 3)
//                
//                VStack(alignment: .leading, spacing: 0) {
//                    ScrollView {
//                        ProfileImageView()
//                            .frame(height: 140)
//                            .padding(.bottom, 30)
//                        SectionHeader(title: "Instructor")
//                        ForEach(menuItems) { item in
//                            MenuItemView(item: item, isOpen: item.isOpen, toggleOpen: {
////                                                          if let index = menuItems.firstIndex(where: { $0.id == item.id }) {
////                                                              menuItems[index].isOpen.toggle()
////
////                                                          }
//                            },action:{})
//                        }
//                        Spacer()
//                    }
//                }
//                .padding(.top, 100)
//                .frame(width: 270)
//                .background(
//                    Color.white
//                )
//            }
//            Spacer()
//        }
//        .background(.clear)
//    }
//    
//    func ProfileImageView() -> some View {
//        VStack(alignment: .center){
//            HStack{
//                Spacer()
//                Image("user")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 100, height: 100)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 50)
//                            .stroke(.purple.opacity(0.5), lineWidth: 10)
//                    )
//                    .cornerRadius(50)
//                Spacer()
//            }
//            
//            Text("Omar Campos")
//                .font(.system(size: 18, weight: .bold))
//                .foregroundColor(.black)
//            
//            Text("IOS Developer")
//                .font(.system(size: 14, weight: .semibold))
//                .foregroundColor(.black.opacity(0.5))
//        }
//    }
//}
//
//struct MenuItemView: View {
//    let item: MenuItem
//       let isOpen: Bool
//       let toggleOpen: () -> Void
//    let action: () -> Void // Agregar un manejador de acción
//       
//       var body: some View {
//           VStack(alignment: .leading) {
//               Button(action: {
//                             if let children = item.children {
//                                 toggleOpen()
//                             } else {
//                                 action() // Llamar a la acción cuando se selecciona el elemento sin hijos
//                             }
//                         }) {
//                             HStack(spacing: 20) {
//                                 Text(item.title)
//                                 Spacer()
//                                 if let children = item.children {
//                                     Image(systemName: "chevron.right")
//                                 }
//                             }
//                             .padding(.leading, 20)
//                             .padding(.vertical, 10)
//                         }
//                         
//                         if let children = item.children, isOpen {
//                             ForEach(children) { child in
//                                 MenuItemView(
//                                     item: child,
//                                     isOpen: false,
//                                     toggleOpen: {},
//                                     action: {}
//                                 )
//                             }
//                         }
//                     }
//           }
//       }
//
//
//
//struct ChildMenuItemView: View {
//    var item: MenuItem
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Button {
//                // Aquí puedes manejar la selección de la opción del menú
//            } label: {
//                HStack(spacing: 40) {
//                    Text(item.title)
//                    Spacer()
//                }
//                .padding(.leading, 40)
//                .padding(.vertical, 10)
//            }
//        }
//    }
//}
