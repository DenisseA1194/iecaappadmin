//import SwiftUI
//
//struct MenuItem: Identifiable {
//    var id = UUID()
//    var title: String
//    var children: [MenuItem]?
//}
//
//struct ContentView: View {
//    let menuItems = [
//        MenuItem(title: "Padre 1", children: [
//            MenuItem(title: "Hijo 1"),
//            MenuItem(title: "Hijo 2")
//        ]),
//        MenuItem(title: "Padre 2", children: [
//            MenuItem(title: "Hijo 3", children: [
//                MenuItem(title: "Nieto 1"),
//                MenuItem(title: "Nieto 2")
//            ]),
//            MenuItem(title: "Hijo 4")
//        ]),
//        MenuItem(title: "Padre 3")
//    ]
//
//    var body: some View {
//        NavigationView {
//            List(menuItems) { item in
//                NavigationLink(destination: MenuItemView(item: item)) {
//                    Text(item.title)
//                }
//            }
//            .navigationBarTitle("Menú")
//        }
//    }
//}
//
//struct MenuItemView: View {
//    var item: MenuItem
//
//    var body: some View {
//        List(item.children ?? []) { child in
//            NavigationLink(destination: GrandchildMenuItemView(item: child)) {
//                Text(child.title)
//            }
//        }
//        .navigationBarTitle(item.title)
//    }
//}
//
//struct GrandchildMenuItemView: View {
//    var item: MenuItem
//
//    var body: some View {
//        Text(item.title)
//            .navigationBarTitle(item.title)
//    }
//}
