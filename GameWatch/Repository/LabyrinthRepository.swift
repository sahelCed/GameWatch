//
//  LabyrinthRepository.swift
//  GameWatch
//
//  Created by Gilberto Pires da Silva Filho on 04/01/2026.
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
}

struct LabyrinthPosition: Codable, Hashable {
    var x: Int
    var y: Int
}

struct LabyrinthRepository {
    
    static var level1: LabyrinthGrid {
        let layout: [String] = [
            "########",
            "#S...#.#",
            "#.##...#",
            "#..#.#.#",
            "##.#.#.#",
            "#..###.#",
            "#..#..E#",
            "########"
        ]
        return fromLayout(layout)
    }
    
    static var level2: LabyrinthGrid {
        let layout: [String] = [
            "##########",
            "#S.#....##",
            "#.##.##.##",
            "#....##..#",
            "####.###.#",
            "#....##.##",
            "#.####...#",
            "#..#...#.#",
            "##...###E#",
            "##########"
        ]
        return fromLayout(layout)
    }
    
    static var level3: LabyrinthGrid {
        let layout: [String] = [
            "############",
            "#S.#.....#.#",
            "#.##.###.#.#",
            "#....###...#",
            "####.###.#.#",
            "#....###.#.#",
            "######...#.#",
            "#.#####.####",
            "#.......##E#",
            "####.####..#",
            "#.........##",
            "############"
        ]
        return fromLayout(layout)
    }
    
    private static func fromLayout(_ layout: [String]) -> LabyrinthGrid {
        var tiles: [[LabyrinthTile]] = []
        var start = LabyrinthPosition(x: 1, y: 1)
        var exit = LabyrinthPosition(x: 1, y: 1)
        
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
