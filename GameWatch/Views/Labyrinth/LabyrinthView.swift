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
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Labyrinthe - Niveau \(labyrinth.currentLevel)/\(labyrinth.maxLevels)")
                .font(.title2.bold())
                .foregroundStyle(.white)
            Text(gameViewModel.getTimer())
                .font(.headline)
                .foregroundStyle(.white)
            
            mazeGrid
                .padding(.horizontal)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if labyrinth.isFinished {
                Text("Tous les niveaux terminés !")
                    .foregroundStyle(.green)
                    .font(.headline)
            } else if labyrinth.currentLevel > 1 && !lastMoveAccepted {
                Text("Niveau \(labyrinth.currentLevel - 1) terminé ! Niveau \(labyrinth.currentLevel) en cours...")
                    .foregroundStyle(.green)
                    .font(.subheadline)
            } else if !lastMoveAccepted {
                Text("Mouvement bloqué")
                    .foregroundStyle(.orange)
                    .font(.subheadline)
            }
            
            Text("Déplacements pilotés depuis l’Apple Watch")
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
        .onChange(of: labyrinth.isFinished) { _, finished in
            if finished, !didDismiss {
                didDismiss = true
                gameViewModel.completeStep(step: stepId)
                dismiss()
            }
        }
    }
    
    private var mazeGrid: some View {
        GeometryReader { geo in
            let rows = labyrinth.grid.height
            let cols = labyrinth.grid.width
            let cellSize = rows > 0 && cols > 0 ? min(geo.size.width / CGFloat(cols), geo.size.height / CGFloat(rows)) : 1
            ZStack {
                Color.black
                ForEach(0..<rows, id: \.self) { y in
                    ForEach(0..<cols, id: \.self) { x in
                        if y < labyrinth.grid.tiles.count, x < labyrinth.grid.tiles[y].count {
                            let tile = labyrinth.grid.tiles[y][x]
                            let tileSize = max(cellSize - 2, 1)
                            Rectangle()
                                .fill(color(for: tile))
                                .frame(width: tileSize, height: tileSize)
                                .position(x: CGFloat(x) * cellSize + cellSize / 2,
                                          y: CGFloat(y) * cellSize + cellSize / 2)
                        }
                    }
                }
                Circle()
                    .fill(Color.blue)
                    .frame(width: cellSize * 0.7, height: cellSize * 0.7)
                    .position(x: CGFloat(labyrinth.playerPosition.x) * cellSize + cellSize / 2,
                              y: CGFloat(labyrinth.playerPosition.y) * cellSize + cellSize / 2)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .border(Color.white.opacity(0.2), width: 1)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private func color(for tile: LabyrinthTile) -> Color {
        switch tile {
        case .wall: return Color.gray.opacity(0.8)
        case .path: return Color.white.opacity(0.08)
        case .exit: return Color.green.opacity(0.6)
        }
    }
}

#Preview {
    LabyrinthView(gameViewModel: GameViewModel(game: GameFactory.gameFrom(difficulty: .easy, options: GameOptions(soundEnabled: true, hapticsEnabled: true, gameExplanationsEnabled: true), name: "Player")), stepId: UUID())
        .background(Color.black)
}
