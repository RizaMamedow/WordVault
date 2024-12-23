//
//  HomeScreen.swift
//  WordVault
//
//  Created by Riza Mamedov on 21.12.2024.
//

import SwiftUI
import SwiftData

struct HomeScreen: View {
    @EnvironmentObject var controller: HomeController
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Top 100 words")) {
                    ForEach(controller.shuffledWordArray, id: \.self) { item in
                        NavigationLink(destination: WordDetailScreen(word: item)) {
                            Text(item.capitalized)
                        }
                    }
                }
            }
            .navigationTitle("WordVault")
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: SearchScreen()) {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
            .refreshable {
                controller.shuffleWords(limit: 100)
            }
            .onAppear {
                controller.shuffleWords(limit: 100)
            }
        }
    }
}

#Preview {
    HomeScreen()
        .environmentObject(HomeController())
}
