//
//  GameOverView.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 27/12/2025.
//

import SwiftUI

struct GameOverView: View {
    let viewModel: GameViewModel
    
    let wonGradient: LinearGradient = LinearGradient(colors: [Color.black, Color.black, Color.green, Color.green], startPoint: .top, endPoint: .bottom)
    
    let lostGradient: LinearGradient = LinearGradient(colors: [Color.black, Color.black, Color.red, Color.red], startPoint: .top, endPoint: .bottom)
    
    
    let wonText: Text = Text("Vous avez gagné !")
        .foregroundStyle(LinearGradient(colors: [Color.green, Color.white], startPoint: .top, endPoint: .bottom))
        .font(.title)
    
    let lostText: Text = Text("Le tyrant vous as attrapé avant que vous ne puissiez vous échapper... Vous avez perdu !")
        .foregroundStyle(LinearGradient(colors: [Color.red, Color.white], startPoint: .top, endPoint: .bottom))
        .font(.title3)
    
    var isWon : Bool {
        viewModel.gameState == .won
    }
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack {
                    Image(isWon ? "win" : "game_over")
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                    isWon ? wonText : lostText
                    
                    GameResumeView(viewModel: viewModel)
                        .padding()
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Revenir au menu")
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(isWon ? .green : .red)
                    .shadow(radius: 20)
                }
            }
            .background(
                isWon ? wonGradient.ignoresSafeArea() : lostGradient.ignoresSafeArea()
            )
        }
    }
}

#Preview {
    let vm = GameViewModel(game: GameFactory.gameFrom(
            difficulty: .easy,
            options: GameOptions(soundEnabled: false, hapticsEnabled: false, gameExplanationsEnabled: false),
            name: "Test Player"
        ))
        
    let stepsToCompleteCount = min(5, vm.game.steps.count)
        
    for i in 0..<stepsToCompleteCount {
        vm.game.steps[i].miniGame.isCompleted = true
    }
    
    vm.gameState = .lost
    
    return GameOverView(viewModel: vm)
}
