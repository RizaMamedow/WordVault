//
//  LoadingScreen.swift
//  WordVault
//
//  Created by Riza Mamedov on 22.12.2024.
//

import SwiftUI


struct LoadingScreen: View {
    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(2)
            Text("Loading...")
                .padding()
                .font(.subheadline)
                .foregroundStyle(.gray)
        }
    }
}
