//
//  Game.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 16/12/2025.
//

import Foundation

struct Game: Identifiable, Codable {
    let id: UUID
    let duration: TimeInterval
    let name: String
    var steps: [GameStep]
    let secretCode: [Major]
    let options: GameOptions
    var hasKey: Bool = false
    
    init(duration: TimeInterval, name: String, steps: [GameStep], secretCode: [Major], options: GameOptions) {
        self.id = UUID()
        self.duration = duration
        self.name = name
        self.steps = steps
        self.secretCode = secretCode
        self.options = options
    }
}
