//
//  GameRootView.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 18/12/2025.
//

import SwiftUI

struct GameRootView: View {
    @State private var viewModel: GameViewModel
    
    init(game: Game) {
        _viewModel = State(initialValue: GameViewModel(game: game))
    }
    
    var body: some View {
        Group {
            if viewModel.isGameStarted {
                GameMapView(viewModel: viewModel)
            } else {
                GameContextView(viewModel: viewModel)
            }
        }
        .environment(viewModel)
    }
}
#Preview {
    GameRootView(game: GameFactory.gameFrom(difficulty: .easy, options: GameOptions.init(soundEnabled: true, hapticsEnabled: true, gameExplanationsEnabled: true), name: "Player 1"))
}
