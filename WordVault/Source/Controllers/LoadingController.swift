//
//  LoadingController.swift
//  WordVault
//
//  Created by Riza Mamedov on 25.12.2024.
//

import Foundation


class LoadingController: ObservableObject {
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    @Published var loadingTextDotCount = 1
    
    func changeLoadingTextDotCount() {
        self.loadingTextDotCount = (self.loadingTextDotCount % 3) + 1
    }
}
