//
//  LicenseView.swift
//  WordVault
//
//  Created by Riza Mamedov on 22.12.2024.
//

import SwiftUI

struct LicenseView: View {
    var license: License
    var sourceUrls: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("License: \(license.name)")
                .font(.subheadline)
                .foregroundColor(.primary)
            
            ForEach(sourceUrls, id: \.self) { url in
                Link("Source: \(url)", destination: URL(string: url)!)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .padding(.top, 5)
            }
        }
    }
}
