//
//  HomeViewModel.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 03/12/2025.
//

import Foundation

extension HomeView {
    @Observable
    class ViewModel {
        private let connectivity: Connectivity
        var presentingCreateGame = false
            
        init(connectivity: Connectivity = .shared) {
            self.connectivity = connectivity
        }
        
        var isWatchConnected: Bool {
            connectivity.watchConnected
        }
                
        
        func checkConnection() {
            connectivity.checkConnection()
        }
    }
}
