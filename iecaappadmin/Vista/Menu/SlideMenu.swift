//
//  SlideMenu.swift
//  iecaappadmin
//
//  Created by Omar on 12/02/24.
//

import SwiftUI


struct HomeView: View {
    
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        VStack{
            HStack{
                Button{
                    presentSideMenu.toggle()
                } label: {
                    Image("hamburguesa")
                        .resizable()
                        .frame(width: 32, height: 32)
                }
                Spacer()
            }
            
            Spacer()
            Text("Home View")
            Spacer()
        }
        .padding(.horizontal, 24)
    }
}

struct SideMenu: View {
    @Binding var isShowing: Bool
    var content: AnyView
    var edgeTransition: AnyTransition = .move(edge: .leading)
    var body: some View {
        ZStack(alignment: .bottom) {
            if (isShowing) {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                content
                    .transition(edgeTransition)
                    .background(
                        Color.clear
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
}

enum SideMenuRowType: Int, CaseIterable{
    case dashboard = 0
    case cursos
    
    case profile
    case evaluaciones
    case ingresos
    case statement
    case editarcurso
    case editarevaluacion
    case tipoSucursal
    case instituto
    
    var title: String{
        switch self {
        case .dashboard:
            return "Dashborad"
        case .cursos:
            return "Cursos"
        case .evaluaciones:
            return "Zonas"
        case .ingresos:
            return "Usuarios"
        case .statement:
            return "Puestos"
        case .editarcurso:
            return "Departamentos"
        case .editarevaluacion:
            return "Sucursales"
        case .profile:
            return "Razon social"
        case .tipoSucursal:
            return "Tipo sucursal"
        case .instituto:
            return "Institucion"
            
        }
        
    }
    
    var iconName: String{
        switch self {
        case .dashboard:
            return "IECA_azul"
        case .cursos:
            return "IECA_azul"
        case .evaluaciones:
            return "IECA_azul"
        case .ingresos:
            return "IECA_azul"
        case .statement:
            return "IECA_azul"
        case .editarcurso:
            return "IECA_azul"
        case .editarevaluacion:
            return "IECA_azul"
        case .profile:
            return "IECA_azul"
        case .tipoSucursal:
            return "IECA_azul"
        case .instituto:
            return "IECA_azul"
        }
    }
}

enum SideMenuRowType2: Int, CaseIterable{
    case home = 0
    case cursos
    case chat
    case profile
    
    var title: String{
        switch self {
        case .home:
            return "Inicio"
        case .cursos:
            return "Cursos disponibles"
        case .chat:
            return "categorias"
        case .profile:
            return "Dashboard"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "IECA_azul"
        case .cursos:
            return "IECA_azul"
        case .chat:
            return "IECA_azul"
        case .profile:
            return "IECA_azul"
        }
    }
}

struct SideMenuView: View {
    
    @Binding var selectedSideMenuTab: Int
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        
        HStack {
            
            ZStack{
                Rectangle()
                    .fill(.white)
                    .frame(width: 270)
                    .shadow(color: .purple.opacity(0.1), radius: 5, x: 0, y: 3)
                
                VStack(alignment: .leading, spacing: 0) {
                    ScrollView {
                        ProfileImageView()
                            .frame(height: 140)
                            .padding(.bottom, 30)
                        SectionHeader(title: "Instructor")
                        ForEach(SideMenuRowType.allCases, id: \.self){ row in
                            RowView(isSelected: selectedSideMenuTab == row.rawValue, imageName: row.iconName, title: row.title) {
                                selectedSideMenuTab = row.rawValue
                                presentSideMenu.toggle()
                            }
                        }
//                        SectionHeader(title: "Alumno")
//                        ForEach(SideMenuRowType2.allCases, id: \.self){ row in
//                            RowView(isSelected: selectedSideMenuTab == row.rawValue, imageName: row.iconName, title: row.title) {
//                                selectedSideMenuTab = row.rawValue
//                                presentSideMenu.toggle()
//                            }
//                        }
                        Spacer()
                    }
                }
                .padding(.top, 100)
                .frame(width: 270)
                .background(
                    Color.white
                )
            }
            
            
            Spacer()
        }
        .background(.clear)
    }
    
    func ProfileImageView() -> some View{
        VStack(alignment: .center){
            HStack{
                Spacer()
                Image("IECA_azul")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(.purple.opacity(0.5), lineWidth: 10)
                    )
                    .cornerRadius(50)
                Spacer()
            }
            
            Text("Usuario")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
            
            Text("IOS Developer")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black.opacity(0.5))
        }
    }
    
    func RowView(isSelected: Bool, imageName: String, title: String, hideDivider: Bool = false, action: @escaping (()->())) -> some View{
        Button{
            action()
        } label: {
            VStack(alignment: .leading){
                HStack(spacing: 20){
                    Rectangle()
                        .fill(isSelected ? .blue : .white)
                        .frame(width: 5)
                    
                    ZStack{
                        Image(imageName)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(isSelected ? .black : .gray)
                            .frame(width: 26, height: 26)
                    }
                    .frame(width: 30, height: 30)
                    Text(title)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(isSelected ? .black : .gray)
                    Spacer()
                }
            }
        }
        .frame(height: 50)
        .background(
            LinearGradient(colors: [isSelected ? .purple.opacity(0.5) : .white, .white], startPoint: .leading, endPoint: .trailing)
        )
    }
}

struct MainTabbedView: View {
    
    @State var presentSideMenu = false
    @State var selectedSideMenuTab = 0
    
    var body: some View {
        ZStack{
            TabView(selection: $selectedSideMenuTab) {
                HomeView(presentSideMenu: $presentSideMenu)
                    .tag(0)
                CursosView(presentSideMenu: $presentSideMenu, showSignInView: $presentSideMenu)
                    .tag(1)
                RazonesSocialesView()
                    .tag(2)
                ZonasView()
                    .tag(3)
                UsuariosView()
                    .tag(4)
                PuestosView(presentSideMenu: $presentSideMenu, showSignInView: $presentSideMenu)
                    .tag(5)
                DepartamentosView()
                    .tag(6)
                SucursalesView()
                    .tag(7)
                TipoSucursalView(presentSideMenu: $presentSideMenu, showSignInView: $presentSideMenu)
                    .tag(8)
                InstitucionesView()
                    .tag(9)
            }.overlay (
                HStack {
                  
                }
                , alignment: .bottom
            )
            
            SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
        }
    }
}

struct SectionHeader: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.gray)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
    }
}
