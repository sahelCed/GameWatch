//
//  HomeViewModel.swift
//  GameWatch Watch App
//
//  Created by Gil Rodrigues on 04/12/2025.
//

import Foundation

extension HomeView {
    
    @Observable
    class ViewModel {
        var isPulsing: Bool = false
        
        private let connectivity: Connectivity
            
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
