//
//  Game.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 16/12/2025.
//

import Foundation

enum GameDifficulty: Int {
    case easy
    case medium
    case hard
}

struct Game: Identifiable, Codable {
    let id: UUID
    let duration: TimeInterval
    let name: String
    let steps: [GameStep]
    
    init(id: UUID, duration: TimeInterval, name: String, steps: [GameStep]) {
        self.id = id
        self.duration = duration
        self.name = name
        self.steps = steps
    }
}

struct GameOptions {
    var soundEnabled: Bool
}

struct GameStep: Identifiable, Codable {
    let id: UUID
    let name: String
    let instruction: String
    
    let type: MiniGameType
    
    let rewardClue: Clue?
}

struct Clue: Identifiable, Codable {
    let id: UUID
    let text: String
    let image: String?
}

enum MiniGameType: String, Codable {
    case finalLock
}
