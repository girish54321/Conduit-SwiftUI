//
//  MyMediumApp.swift
//  MyMedium
//
//  Created by neosoft on 09/01/23.
//

import SwiftUI

@main
struct MyMediumApp: App {
    
    @AppStorage(AppConst.isLogedIn) var isLogedIn: Bool = false
    
    var body: some Scene {
        WindowGroup {
            WelcomeScreen()
                .environmentObject(AlertViewModel())
        }
    }
}
