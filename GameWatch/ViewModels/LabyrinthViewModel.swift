//
//  LabyrinthViewModel.swift
//  GameWatch
//
//  Created by Gilberto Pires da Silva Filho on 02/01/2026.
//

import Foundation

@Observable
final class LabyrinthViewModel {
    private(set) var grid: LabyrinthGrid
    private(set) var playerPosition: LabyrinthPosition
    private(set) var isFinished: Bool = false
    private(set) var currentLevel: Int = 1
    let maxLevels: Int = 3
    
    init(grid: LabyrinthGrid = LabyrinthRepository.level1) {
        self.grid = grid
        self.playerPosition = grid.start
        self.isFinished = false
        self.currentLevel = 1
    }
    
    @discardableResult
    func move(_ direction: LabyrinthDirection) -> Bool {
        guard !isFinished else { return false }
        let next = nextPosition(from: playerPosition, direction: direction)
        guard let tile = grid.tile(at: next), tile != .wall else {
            return false
        }
        playerPosition = next
        if tile == .exit {
            if currentLevel < maxLevels {
                nextLevel()
            } else {
                isFinished = true
            }
        }
        return true
    }
    
    private func nextLevel() {
        currentLevel += 1
        switch currentLevel {
        case 2:
            grid = LabyrinthRepository.level2
        case 3:
            grid = LabyrinthRepository.level3
        default:
            grid = LabyrinthRepository.level1
        }
        playerPosition = grid.start
    }
    
    private func nextPosition(from position: LabyrinthPosition, direction: LabyrinthDirection) -> LabyrinthPosition {
        switch direction {
        case .up:
            return LabyrinthPosition(x: position.x, y: position.y - 1)
        case .down:
            return LabyrinthPosition(x: position.x, y: position.y + 1)
        case .left:
            return LabyrinthPosition(x: position.x - 1, y: position.y)
        case .right:
            return LabyrinthPosition(x: position.x + 1, y: position.y)
        }
    }
}
