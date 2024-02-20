//
//  iecaappadminApp.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 16/01/24.
//

import SwiftUI
import Firebase
@main
struct iecaappadminApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        var body: some Scene {
            WindowGroup {
                NavigationStack{
                    Login()
                }
            }
        }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    print("Configured Firebase!")
      return true
    }
}
