//
//  MiniGameType.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 17/12/2025.
//


enum MiniGameType: String, Codable, CaseIterable {
    case finalLock
    case simonSays
    case labyrinth
    case tapCounter
    case search
    case exit
    
    
    static var playableGames: [MiniGameType] {
        return allCases.filter { $0 != .finalLock && $0 != .search && $0 != .exit}
    }
}
