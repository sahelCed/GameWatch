//
//  GameContextView.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 19/12/2025.
//

import SwiftUI

struct GameContextView: View {
    var viewModel: GameViewModel
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 20) {
                ZStack {
                    SpeechBubbleView(
                        text: """
                        Le Tyran Sananes a verrouillé l'école ! Le seul moyen de sortir, c'est de trouver le code.
                        Il paraît que c'est basé sur son **Classement secret des Filières** de l'ESGI.
                                        
                        **Fouille les salles et trouve les indices cachés** pour reconstituer l'ordre exact. Fais vite ! S'il te surprend ici, il te fera coder de l'assembleur sur papier !
                        """
                    )
                }
                .frame(width: 320)
                .padding(.bottom, -150)
                .padding(.top, 100)
                Image(.esgiMaleFront)
                    .resizable()
                    .frame(width: 400, height: 300)
                Spacer()
                Button {
                    withAnimation {
                        viewModel.startGame()
                    }
                } label: {
                    Text("COMMENCER LA PARTIE")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                }
        }
    }
}

#Preview {
    GameContextView(viewModel: GameViewModel(game: GameFactory.gameFrom(difficulty: .easy, options: GameOptions(soundEnabled: true, hapticsEnabled: true, gameExplanationsEnabled: true), name: "Player")))
}
