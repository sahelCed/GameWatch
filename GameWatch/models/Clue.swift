//
//  Clue.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 17/12/2025.
//

import Foundation



struct Clue: Identifiable, Codable {
    var id: UUID = UUID()
    let text: String
    let image: String?
    
    init(id: UUID = UUID(), text: String, image: String? = nil) {
        self.id = id
        self.text = text
        self.image = image
    }
}
