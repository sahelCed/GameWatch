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
        var playerName: String = ""
        var timeRemaining: String = "--:--"
        var gameStarted: Bool = false
        var shouldNavigateToLabyrinth: Bool = false
        
        private let connectivity: Connectivity
            
        init(connectivity: Connectivity = .shared) {
            self.connectivity = connectivity
            setupMessageListener()
        }
        
        var isWatchConnected: Bool {
            connectivity.watchConnected
        }
                
        
        func checkConnection() {
            connectivity.checkConnection()
        }
        
        private func setupMessageListener() {
            NotificationCenter.default.addObserver(
                forName: .watchGameMessage,
                object: nil,
                queue: .main
            ) { [weak self] notification in
                guard let message = notification.userInfo as? [String: Any] else { return }
                self?.handleMessage(message)
            }
        }
        
        private func handleMessage(_ message: [String: Any]) {
            guard let action = message[LabyrinthMessageKeys.action] as? String else { return }
            
            switch action {
            case LabyrinthMessageKeys.gameStartAction:
                if let name = message[LabyrinthMessageKeys.playerName] as? String {
                    playerName = name
                }
                if let time = message[LabyrinthMessageKeys.timeRemaining] as? TimeInterval {
                    let minutes = Int(time / 60)
                    let seconds = Int(time) % 60
                    timeRemaining = String(format: "%02d:%02d", minutes, seconds)
                }
                gameStarted = true
                
            case LabyrinthMessageKeys.labyrinthStartAction:
                shouldNavigateToLabyrinth = true
                
            case LabyrinthMessageKeys.labyrinthEndAction:
                shouldNavigateToLabyrinth = false
                
            case LabyrinthMessageKeys.timerUpdateAction:
                if let time = message[LabyrinthMessageKeys.timeRemaining] as? TimeInterval {
                    let minutes = Int(time / 60)
                    let seconds = Int(time) % 60
                    timeRemaining = String(format: "%02d:%02d", minutes, seconds)
                }
                
            default:
                break
            }
        }
    }
}
