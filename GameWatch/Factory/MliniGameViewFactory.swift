//
//  MliniGameViewFactory.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 27/12/2025.
//

import SwiftUI

@ViewBuilder
func viewForMiniGame(game: GameViewModel, step: GameStep) -> some View {
    switch step.miniGame.type {
    case .simonSays:
        Text("Vue Simon Says à implémenter")
    case .finalLock:
        FinalLockView(game: game, step: step)
    case .labyrinth:
        LabyrinthView(gameViewModel: game, stepId: step.id)
    default:
        Text("Jeu inconnu")
    }
}
