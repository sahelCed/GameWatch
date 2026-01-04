//
//  LabyrinthViewModel.swift
//  GameWatch
//
//  Created by Gilberto Pires da Silva Filho on 02/01/2026.
//

import Foundation

struct LabyrinthGrid: Codable {
    let width: Int
    let height: Int
    let tiles: [[LabyrinthTile]]
    let start: LabyrinthPosition
    let exit: LabyrinthPosition
    
    init(tiles: [[LabyrinthTile]], start: LabyrinthPosition, exit: LabyrinthPosition) {
        self.tiles = tiles
        self.height = tiles.count
        self.width = tiles.first?.count ?? 0
        self.start = start
        self.exit = exit
    }
    
    func tile(at position: LabyrinthPosition) -> LabyrinthTile? {
        guard position.x >= 0, position.y >= 0, position.y < height, position.x < width else {
            return nil
        }
        return tiles[position.y][position.x]
    }
    
    static var sample: LabyrinthGrid {
        let layout: [String] = [
            "########",
            "#S....#",
            "#.##..#",
            "#..#..#",
            "##.#.##",
            "#..#..#",
            "#...E.#",
            "########"
        ]
        var tiles: [[LabyrinthTile]] = []
        var start = LabyrinthPosition(x: 1, y: 1)
        var exit = LabyrinthPosition(x: 4, y: 6)
        
        for (y, row) in layout.enumerated() {
            var line: [LabyrinthTile] = []
            for (x, char) in row.enumerated() {
                switch char {
                case "#": line.append(.wall)
                case "E":
                    line.append(.exit)
                    exit = LabyrinthPosition(x: x, y: y)
                case "S":
                    line.append(.path)
                    start = LabyrinthPosition(x: x, y: y)
                default:
                    line.append(.path)
                }
            }
            tiles.append(line)
        }
        return LabyrinthGrid(tiles: tiles, start: start, exit: exit)
    }
}

struct LabyrinthPosition: Codable, Hashable {
    var x: Int
    var y: Int
}

@Observable
final class LabyrinthViewModel {
    private(set) var grid: LabyrinthGrid
    private(set) var playerPosition: LabyrinthPosition
    private(set) var isFinished: Bool = false
    
    init(grid: LabyrinthGrid = .sample) {
        self.grid = grid
        self.playerPosition = grid.start
        self.isFinished = false
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
            isFinished = true
        }
        return true
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
