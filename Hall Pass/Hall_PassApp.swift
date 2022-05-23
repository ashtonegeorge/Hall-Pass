//
//  Hall_PassApp.swift
//  Hall Pass
//
//  Created by Ashton George on 2/11/22.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct Hall_PassApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(SignUpViewModel())
                .environmentObject(RequestManager())
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
    [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
      
    FirebaseApp.configure()
    return true
      
  }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return GIDSignIn.sharedInstance.handle(url)
        
    }
    
}

