//
//  LoadingScreen.swift
//  WordVault
//
//  Created by Riza Mamedov on 22.12.2024.
//

import SwiftUI


struct LoadingScreen: View {
    @StateObject private var controller: LoadingController = .init()

    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(2)
            
            Text("Loading" + String(repeating: ".", count: controller.loadingTextDotCount))
               .padding()
               .font(.subheadline)
               .foregroundStyle(.gray)
               .onReceive(controller.timer) { _ in
                   controller.changeLoadingTextDotCount()
               }
        }
    }
}
