//
//  SimonSaysView.swift
//  GameWatch
//
//  Created by Cedric Ait sahel on 07/01/2026.
//
import SwiftUI

struct SimonSaysView: View {
    var game: GameViewModel
    var step: GameStep
    var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        GeometryReader{ geo in
            if viewModel.start {
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        Rectangle().fill(viewModel.currentSimonColor == .blue ? Color.blue : Color.blue.opacity(0.2) )
                        Rectangle().fill(viewModel.currentSimonColor == .red ? Color.red : Color.red.opacity(0.2) )
                    }
                    
                    HStack(spacing: 16) {
                        Rectangle().fill(viewModel.currentSimonColor == .yellow ? Color.yellow : Color.yellow.opacity(0.2) )
                        Rectangle().fill(viewModel.currentSimonColor == .green ? Color.green : Color.green.opacity(0.2) )
                    }
                }
                .frame(width:geo.size.width,height: geo.size.height)
            } else {
                VStack(spacing: 16) {
                    Button("start") {
                        viewModel.startGame()
                    }
                }

            }
            

        }

    }
}

#Preview {
    let game = GameFactory.gameFrom(difficulty: .medium, options: GameOptions(soundEnabled: .random(), hapticsEnabled: .random(), gameExplanationsEnabled: .random()), name: "")
    
    let vm = GameViewModel(game: game)
    
    let step = game.steps.first(where: { $0.miniGame.type == .finalLock })
    
    SimonSaysView(game: vm, step: step!)
}



