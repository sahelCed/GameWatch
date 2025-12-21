//
//  MapLocation.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 20/12/2025.
//

internal import CoreGraphics

struct RoomLocation: Codable, Hashable {
    let centerXRelativeToWidth: CGFloat
    let centerYRelativeToHeight: CGFloat
    
    let widthRelativeToMap: CGFloat
    let heightRelativeToMap: CGFloat
}
