//
//  RoomView.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 20/12/2025.
//

import SwiftUI

struct RoomView: View {
    let step: GameStep
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Rectangle()
                    .fill(step.miniGame.isCompleted ? Color.green.opacity(0.6) : Color.red.opacity(0.3))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(step.miniGame.isCompleted ? Color.green : Color.red, lineWidth: 2)
                    )
                VStack {
                    Text(step.room.name)
                    
                    if step.miniGame.isCompleted {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    } else {
                        if step.miniGame.type == .exit {
                            Image(systemName: "door.left.hand.closed")
                                .font(.title2)
                                .foregroundColor(.white.opacity(0.8))
                        }else {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .font(.title2)
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }
                }
                
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    
    RoomView(step: GameStep(miniGame: MiniGameFactory.miniGameFrom(miniGameType: .exit), room: RoomsRepository.a04, rewardClue: Clue(text: "yess"))) {
        
    }
}
