//
//  WordVaultApp.swift
//  WordVault
//
//  Created by Riza Mamedov on 21.12.2024.
//

import SwiftUI
import SwiftData

@main
struct WordVaultApp: App {
    @ObservedObject var homeController: HomeController = .init()
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environmentObject(homeController)
        }
    }
}
