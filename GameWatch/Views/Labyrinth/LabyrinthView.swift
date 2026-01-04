//
//  LabyrinthView.swift
//  GameWatch
//
//  Created by Gilberto Pires da Silva Filho on 02/01/2026.
//

import SwiftUI

struct LabyrinthView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var gameViewModel: GameViewModel
    let stepId: UUID
    @State private var labyrinth = LabyrinthViewModel()
    @State private var lastMoveAccepted: Bool = true
    @State private var didDismiss = false
    @State private var previousLevel: Int = 1
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Labyrinthe - Niveau \(labyrinth.currentLevel)/\(labyrinth.maxLevels)")
                .font(.title2.bold())
                .foregroundStyle(.white)
            Text(gameViewModel.getTimer())
                .font(.headline)
                .foregroundStyle(.white)
            
            LabyrinthGridView(grid: labyrinth.grid, playerPosition: labyrinth.playerPosition)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if labyrinth.isFinished {
                Text("Tous les niveaux terminés !")
                    .foregroundStyle(.green)
                    .font(.headline)
            } else if labyrinth.currentLevel > previousLevel {
                Text("Niveau \(previousLevel) terminé ! Niveau \(labyrinth.currentLevel) en cours...")
                    .foregroundStyle(.green)
                    .font(.subheadline)
            } else if !lastMoveAccepted {
                Text("Mouvement bloqué")
                    .foregroundStyle(.orange)
                    .font(.subheadline)
            }
            
            Text("Déplacements pilotés depuis l'Apple Watch")
                .foregroundStyle(.gray)
                .font(.footnote)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            Connectivity.shared.send([
                LabyrinthMessageKeys.action: LabyrinthMessageKeys.labyrinthStartAction
            ])
        }
        .onDisappear {
            Connectivity.shared.send([
                LabyrinthMessageKeys.action: LabyrinthMessageKeys.labyrinthEndAction
            ])
        }
        .onReceive(NotificationCenter.default.publisher(for: .labyrinthMove)) { notif in
            guard let direction = notif.userInfo?[LabyrinthMessageKeys.direction] as? LabyrinthDirection else { return }
            let moved = labyrinth.move(direction)
            lastMoveAccepted = moved
        }
        .onChange(of: labyrinth.currentLevel) { _, newLevel in
            previousLevel = newLevel
        }
        .onChange(of: labyrinth.isFinished) { _, finished in
            if finished, !didDismiss {
                didDismiss = true
                gameViewModel.completeStep(step: stepId)
                dismiss()
            }
        }
    }
}

#Preview {
    LabyrinthView(gameViewModel: GameViewModel(game: GameFactory.gameFrom(difficulty: .easy, options: GameOptions(soundEnabled: true, hapticsEnabled: true, gameExplanationsEnabled: true), name: "Player")), stepId: UUID())
        .background(Color.black)
}
