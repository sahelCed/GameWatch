//
//  TimeIntervalExtension.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 17/12/2025.
//

import Foundation

extension TimeInterval {
    static func minutes(_ value: Double) -> TimeInterval {
        return value * 60
    }
}
