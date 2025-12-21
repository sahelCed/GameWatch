//
//  GameStep.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 17/12/2025.
//

import Foundation


struct GameStep: Identifiable, Codable {
    var id: UUID = UUID()
    var miniGame: MiniGame
    let room: Room
    
    let rewardClue: Clue?
}
