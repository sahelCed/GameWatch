//
//  MiniGame.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 21/12/2025.
//

struct MiniGame: Decodable, Encodable {
    let name: String
    let instruction: String
    var isCompleted: Bool = false
    let type: MiniGameType
    let image: String
    
    init(name: String, instruction: String, isCompleted: Bool, type: MiniGameType, image: String) {
        self.name = name
        self.instruction = instruction
        self.isCompleted = isCompleted
        self.type = type
        self.image = image
    }
}
