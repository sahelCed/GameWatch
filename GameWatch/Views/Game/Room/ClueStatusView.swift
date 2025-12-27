//
//  ClueStatusView.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 27/12/2025.
//

import SwiftUI

struct ClueStatusView: View {
    var viewModel: GameViewModel
    
    let stepId: UUID
    
    var step: GameStep {
        return viewModel.game.steps.first(where: { $0.id == stepId })!
    }
    
    var body: some View {
        if step.miniGame.isCompleted {
            VStack {
                Text("Indice :")
                    .foregroundStyle(.green)
                    .font(.title3)
                Text(step.rewardClue!.text)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding()
            
            if step.miniGame.isCompleted,
               let clue = step.rewardClue,
               let imageName = clue.image {
                                
                ZStack {

                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 180, height: 180)
                        
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                }
            }
        }else {
            VStack {
                HStack {
                    Text("Indice pas encore débloqué")
                        .foregroundStyle(.red)
                        .font(.title3)
                    Image(systemName: "lock.fill")
                        .foregroundStyle(.red)
                }
                .padding()
            }
        }
    }
}

