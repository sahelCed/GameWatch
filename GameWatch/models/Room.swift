//
//  Room.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 21/12/2025.
//

import Foundation

struct Room: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    let backgroundImageName: String
    let roomLocation: RoomLocation
}
