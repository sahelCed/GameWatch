//
//  RoomView.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 23/12/2025.
//

import SwiftUI

struct RoomView: View {
    var viewModel: GameViewModel
    
    var stepId: UUID
    
    var step : GameStep {
        return viewModel.game.steps.first(where: { $0.id == stepId })!
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack {
                    Text(viewModel.getTimer())
                        .foregroundStyle(.white)
                        .font(.title)
                    
                    Image(step.room.backgroundImageName)
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                    Text(step.room.name)
                        .foregroundStyle(.white)
                        .padding()
                        .font(.largeTitle)
                        .bold()
                      
                    RoomMainContentView(viewModel: viewModel, stepId: stepId, buttonSize: geo.size.width * 0.3)
                    
                }
            }
            .background(Color.black.ignoresSafeArea())
            .navigationDestination(for: GameStep.self) { targetStep in
                viewForMiniGame(game: viewModel, step: targetStep, viewModel: viewModel)
            }
        }
    }
}

#Preview {
    let vm = GameViewModel(game: GameFactory.gameFrom(difficulty: .easy, options: GameOptions(soundEnabled: true, hapticsEnabled: true, gameExplanationsEnabled: true), name: "player 1"))
    RoomView(viewModel: vm, stepId: vm.game.steps.first(where: { $0.miniGame.type == .search})!.id)
}
