//
//  ErrorScreen.swift
//  WordVault
//
//  Created by Riza Mamedov on 22.12.2024.
//

import SwiftUI

struct ErrorScreen: View {
    @Environment(\.dismiss) private var dismiss
    var errorMessage: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "x.circle.fill")
                .foregroundStyle(.red)
                .font(.system(size: 50))
            Text(errorMessage)
                .font(.subheadline)
                .foregroundStyle(.red)
            Button {
                dismiss()
            } label: {
                Label("Go Back", systemImage: "chevron.backward")
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    ErrorScreen(errorMessage: "Some error for preview")
}
