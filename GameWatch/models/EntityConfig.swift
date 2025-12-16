//
//  EntityConfig.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 09/12/2025.
//

import Foundation
internal import CoreGraphics

struct EntityConfig {
    var size: CGSize
    var start: CGPoint
    var end: CGPoint
    
    init(size: CGSize = .init(width: 120, height: 120), start: CGPoint = .zero, end: CGPoint = .zero) {
        self.size = size
        self.start = start
        self.end = end
    }
}
