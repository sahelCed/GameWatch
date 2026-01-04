//
//  MliniGameViewFactory.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 27/12/2025.
//

import SwiftUI

@ViewBuilder
func viewForMiniGame(game: GameViewModel, step: GameStep, viewModel: GameViewModel) -> some View {
    switch step.miniGame.type {
    case .simonSays:
        Text("Vue Simon Says à implémenter")
    case .finalLock:
        Text("final lock to implement")
    case .labyrinth:
        LabyrinthView(gameViewModel: viewModel, stepId: step.id)
    default:
        Text("Jeu inconnu")
    }
}
