//
//  CreateGameView.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 16/12/2025.
//

import SwiftUI

struct CreateGameView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
            NavigationStack {
                ZStack {
                    LinearGradient(
                        colors: [viewModel.firstGradientColor(), viewModel.secondGradientColor(), viewModel.thirdGradientColor()],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                    .animation(.linear(duration: 1.5), value: viewModel.difficulty)
                    
                    Form {
                        Section(header: Text("Nom du joueur").foregroundStyle(.black)) {
                            TextField("Nom du joueur", text: $viewModel.playerName)
                                .listRowBackground(
                                    Rectangle()
                                        .fill(.ultraThinMaterial)
                                )
                        }
                        
                        DifficultyPickerView(selectedDifficulty: $viewModel.difficulty)
                        
                        Section(header: Text("Immersion").foregroundStyle(.black)) {
                            Toggle("Son", isOn: $viewModel.gameOptions.soundEnabled)
                                .tint(viewModel.toggleTint())
                                .listRowBackground(
                                    glassBackground
                                )
                            Toggle("Vibrations", isOn: $viewModel.gameOptions.hapticsEnabled)
                                .tint(viewModel.toggleTint())
                                .listRowBackground(
                                    glassBackground
                                )
                            Toggle("Explications des épreuves", isOn: $viewModel.gameOptions.gameExplanationsEnabled)
                                .tint(viewModel.toggleTint())
                                .listRowBackground(
                                    glassBackground
                                )
                        }
                        
                        Button {
                            viewModel.createGame()
                        } label: {
                            Text("Lancez la partie")
                                .frame(maxWidth: .infinity)
                                .bold()
                                .foregroundStyle(.white)
                        }
                        .listRowBackground(viewModel.toggleTint()
                            .animation(.linear(duration: 1.5), value: viewModel.difficulty)
                        )
                    }
                    .scrollContentBackground(.hidden)
                    .animation(.linear(duration: 1.5), value: viewModel.difficulty)
                }
                .navigationTitle("Créer une partie")
                .toolbarColorScheme(.dark, for: .navigationBar)
                .fullScreenCover(isPresented: $viewModel.isGameLaunched) {
                    if let game = viewModel.createdGame {
                        GameRootView(game: game)
                    }
                }
            }
        }
        
}


var glassBackground: some View {
    Rectangle()
        .fill(.ultraThinMaterial)
}

#Preview {
    CreateGameView()
}
