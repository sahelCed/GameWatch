//
//  GameResumeView.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 04/01/2026.
//

import SwiftUI

struct GameResumeView: View {
    let viewModel: GameViewModel
    let game : Game
    
    var isWon : Bool {
        viewModel.gameState == .won
    }
    
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
        self.game = viewModel.game
    }
    
    var body: some View {
            VStack {
                Text("Résumé de la partie")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(LinearGradient(colors: [isWon ? Color.green : Color.red, Color.white], startPoint: .top, endPoint: .bottom))
                
                Text("Joueur : \(game.name)")
                    .font(.headline)
                    .padding()
                    .foregroundStyle(.white)
                
                let completedSteps = game.steps.filter { $0.miniGame.isCompleted }
                
                if completedSteps.isEmpty {
                    ContentUnavailableView("Aucune étape complétée", systemImage: "xmark.circle")
                } else {
                    VStack(alignment: .leading) {
                        Text("Indices obtenue :")
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        
                        List(completedSteps) { step in
                            HStack(alignment: .top, spacing: 15) {
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    
                                    if let clue = step.rewardClue {
                                        HStack(alignment: .top) {
                                            Image(systemName: "lightbulb.fill")
                                                .foregroundStyle(.yellow)
                                                .font(.caption)
                                            
                                            VStack(alignment: .leading) {
                                                Text(clue.text)
                                                    .font(.subheadline)
                                                    .foregroundStyle(.white)
                                                
                                                if let imageName = clue.image {
                                                    Image(imageName)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: 60)
                                                        .cornerRadius(8)
                                                        .padding(.top, 4)
                                                    
                                                }
                                            }
                                        }
                                        .padding(.top, 4)
                                        .padding(8)
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(8)
                                    }
                                }
                            }
                            .padding(.vertical, 4)
                            .listRowBackground(Color.clear)
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        
                    }
                    Text("Temps restant :")
                        .foregroundStyle(.white)
                        .padding()
                        .fontWeight(.bold)
                    
                    Text(isWon ? viewModel.getTimer() : "00:00")
                        .foregroundStyle(.white)
                }
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
    
        
        return GameResumeView(viewModel: vm)
}
