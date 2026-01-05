//
//  FinalLockView.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 05/01/2026.
//

import SwiftUI

struct FinalLockView: View {
    var game: GameViewModel
    var step: GameStep
    @State private var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    
    
    init(game: GameViewModel, step: GameStep) {
        self.game = game
        self.step = step
        let secretCode = game.game.secretCode
        _viewModel = State(initialValue: ViewModel(secretCode: secretCode))
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("\(game.getTimer())")
                    .foregroundStyle(.white)
                    .font(.title)

                Image("final_lock")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                CryptexView(selection: $viewModel.cryptexCode)
                if viewModel.penalityApplied {
                    Text("Code incorrect, une alarme a été déclenchée. Vous avez perdu \(game.getPenality())sc.")
                        .foregroundStyle(.red)
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()
                }
                Button {
                    if viewModel.validateCode() {
                        game.completeStep(step: step.id)
                        dismiss()
                    }else {
                        game.applyPenality()
                        viewModel.penalityApplied = true
                    }
                } label: {
                    Text("Dévérouiller")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.glassProminent)
                .tint(.orange.opacity(0.6))
                .padding()
                .frame(width: geo.size.width * 0.66)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .background(.black)
    }
}

#Preview {
    let game = GameFactory.gameFrom(difficulty: .medium, options: GameOptions(soundEnabled: .random(), hapticsEnabled: .random(), gameExplanationsEnabled: .random()), name: "")
    
    let vm = GameViewModel(game: game)
    
    let step = game.steps.first(where: { $0.miniGame.type == .finalLock })
    
    FinalLockView(game: vm, step: step!)
}
