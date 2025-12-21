//
//  CreateGameViewModel.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 17/12/2025.
//

import Foundation
import SwiftUI

extension CreateGameView {
    @Observable
    class ViewModel {
        var playerName: String = ""
        var difficulty: GameDifficulty = .easy
        var gameOptions: GameOptions = GameOptions(soundEnabled: true, hapticsEnabled: true, gameExplanationsEnabled: true)
        
        var createdGame: Game?
        var isGameLaunched: Bool = false
        
        func createGame() {
            let name = playerName.isEmpty ? "Unknown" : playerName
            
            self.createdGame = GameFactory.gameFrom(
                difficulty: difficulty,
                options: gameOptions,
                name: name
            )
            
            self.isGameLaunched = true
        }
        
        func firstGradientColor() -> Color {
            switch difficulty {
            case .easy:
                return .blue
            case .medium:
                return .yellow
            case .hard:
                return .orange
            }
        }
        
        func secondGradientColor() -> Color {
            switch difficulty {
            case .easy:
                return .yellow
            case .medium:
                return .orange
            case .hard:
                return .red
            }
        }
        
        func thirdGradientColor() -> Color {
            switch difficulty {
            case .easy:
                return .orange
            case .medium:
                return .red
            case .hard:
                return .black
            }
        }
        
        func toggleTint() -> Color {
            switch difficulty {
            case .easy:
                return .blue
            case .medium:
                return .yellow
            case .hard:
                return .orange
            }
        }
    }
}
