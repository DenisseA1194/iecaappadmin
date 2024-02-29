//
//  MainTabbedView.swift
//  iecaappadmin
//
//  Created by Omar on 26/02/24.
//

import SwiftUI

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
            }
            
            
            SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
        }
    }
}

#Preview {
    MainTabbedView()
}
