//
//  GameViewModel.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 17/12/2025.
//

import Foundation

@Observable
class GameViewModel {
    var game: Game
        
    var currentStepIndex: Int = 0
    var isGameStarted: Bool = false
    var timeRemaining: TimeInterval
        
    init(game: Game) {
        self.game = game
        self.timeRemaining = game.duration
    }
    
    func startGame() {
        isGameStarted = true
    }
    
    func completeStep(step: UUID) {
        if let index = game.steps.firstIndex(where: { $0.id == step }) {
            
            let type = game.steps[index].miniGame.type
            
            if type == .exit {
                if game.hasKey {
                    game.steps[index].miniGame.isCompleted = true
                }
            } else {
                game.steps[index].miniGame.isCompleted = true
            }
        }
    }
}
