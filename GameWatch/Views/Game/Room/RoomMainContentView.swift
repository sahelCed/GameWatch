//
//  RoomUnplayableTypeMiniGame.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 27/12/2025.
//

import SwiftUI

struct RoomMainContentView: View {
    
    var viewModel: GameViewModel
    
    let stepId: UUID
    
    @Environment(\.dismiss) private var dismiss
    
    var step: GameStep {
        return viewModel.game.steps.first(where: { $0.id == stepId })!
    }
    
    let buttonSize: CGFloat
    
    var body: some View {
        VStack {
            Text(step.miniGame.name)
                .foregroundStyle(.white)
                .font(.title3)
                .bold()
                .multilineTextAlignment(.center)
                .padding()
                .fixedSize(horizontal: false, vertical: true)
            
            if MiniGameType.playableGames.contains(step.miniGame.type) || step.miniGame.type == .finalLock {
                if !step.miniGame.isCompleted {
                    NavigationLink(value: step) {
                        Image(step.miniGame.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: buttonSize)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 10)
                    }
                    .padding()
                } else {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(.green)
                }
            }else {
                
                if !step.miniGame.isCompleted {
                    Button {
                        withAnimation {
                            viewModel.completeStep(step: step.id)
                        }
                    } label: {
                        Image(step.miniGame.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: buttonSize)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 10)
                    }
                } else {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(.green)
                }
            }
            if step.miniGame.type == .exit {
                Text("Utilisez la clé pour sortir")
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
            }else {
                ClueStatusView(viewModel: viewModel, stepId: step.id)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    let game = GameViewModel(game: GameFactory.gameFrom(difficulty: .easy, options: GameOptions(soundEnabled: false, hapticsEnabled: false, gameExplanationsEnabled: false), name: ""))
    
    let step = game.game.steps.first(where: { $0.miniGame.type == .exit })!
    
    GeometryReader { geo in
        RoomMainContentView(viewModel: game, stepId: step.id, buttonSize: geo.size.width * 0.3)
    }
    .background(Color.black)
}
