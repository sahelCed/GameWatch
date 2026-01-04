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
    
    var timer: Timer?
        
    init(game: Game) {
        self.game = game
        self.timeRemaining = game.duration
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func startGame() {
        stopTimer()
        
        isGameStarted = true
        
        Connectivity.shared.send([
            LabyrinthMessageKeys.action: LabyrinthMessageKeys.gameStartAction,
            LabyrinthMessageKeys.playerName: game.name,
            LabyrinthMessageKeys.timeRemaining: timeRemaining
        ])
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateTimer()
        }
    }
    
    private func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            // Envoyer la mise à jour du timer à la Watch
            Connectivity.shared.send([
                LabyrinthMessageKeys.action: LabyrinthMessageKeys.timerUpdateAction,
                LabyrinthMessageKeys.timeRemaining: timeRemaining
            ])
        } else {
            stopTimer()
            print("Temps écoulé !") //game over to implement
        }
    }
    
    func getTimer() -> String {
        let minutes = Int(timeRemaining / 60)
        let seconds = Int(timeRemaining) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func completeStep(step: UUID) {
        if let index = game.steps.firstIndex(where: { $0.id == step }) {
            
            let type = game.steps[index].miniGame.type
            
            if type == .exit {
                if game.hasKey {
                    game.steps[index].miniGame.isCompleted = true
                    stopTimer()
                }
            } else {
                game.steps[index].miniGame.isCompleted = true
            }
        }
    }
}
