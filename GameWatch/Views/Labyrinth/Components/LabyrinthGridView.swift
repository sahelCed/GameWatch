//
//  LabyrinthGridView.swift
//  GameWatch
//
//  Created by Gilberto Pires da Silva Filho on 05/01/2026.
//

import SwiftUI

struct LabyrinthGridView: View {
    let grid: LabyrinthGrid
    let playerPosition: LabyrinthPosition
    
    var body: some View {
        GeometryReader { geo in
            let rows = grid.height
            let cols = grid.width
            let cellSize = rows > 0 && cols > 0 ? min(geo.size.width / CGFloat(cols), geo.size.height / CGFloat(rows)) : 1
            ZStack {
                Color.black
                ForEach(0..<rows, id: \.self) { y in
                    ForEach(0..<cols, id: \.self) { x in
                        if y < grid.tiles.count, x < grid.tiles[y].count {
                            let tile = grid.tiles[y][x]
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
                    .position(x: CGFloat(playerPosition.x) * cellSize + cellSize / 2,
                              y: CGFloat(playerPosition.y) * cellSize + cellSize / 2)
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
    LabyrinthGridView(
        grid: LabyrinthRepository.level1,
        playerPosition: LabyrinthRepository.level1.start
    )
    .background(Color.black)
}
