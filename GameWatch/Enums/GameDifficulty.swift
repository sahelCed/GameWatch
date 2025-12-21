//
//  GameDifficulty.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 17/12/2025.
//

import SwiftUI

enum GameDifficulty: String, Codable, CaseIterable {
    case easy
    case medium
    case hard
    
    var color: Color {
        switch self {
        case .easy: return .blue
        case .medium: return .yellow
        case .hard: return .orange
        }
    }
    
    var title: String {
        switch self {
            case .easy: return "Facile"
            case .medium: return "Moyen"
            case .hard: return "Difficile"
        }
    }
}
