//
//  BackgroundAnimationViewModel.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 04/12/2025.
//

import Foundation
internal import CoreGraphics
internal import DeveloperToolsSupport
import UIKit
import SwiftUI

extension BackgroundAnimationView {
    @Observable
    class ViewModel {
        
        var isRunning: Bool = false
        private var isRandomMode: Bool = false
        private var shouldStop: Bool = false
        
        var characters: EntityConfig
        var monster: EntityConfig
        
        var duration: Double
        var delay: Double
        var repeatForever: Bool
        
        var spaceToMonster: CGFloat
        var spaceBetweenCharacters: CGFloat
        
        var reverse: Bool
        var vertical: Bool
        
        private let initialConfig: (chars: EntityConfig, monster: EntityConfig, duration: Double, delay: Double, reverse: Bool, vertical: Bool, repeat: Bool)
        
        private let screenWidth = UIScreen.main.bounds.width
        private let screenHeight = UIScreen.main.bounds.height
        
        init(duration: Double = 2.0, delay: Double, repeatForever: Bool = false, reverse: Bool = false, vertical: Bool = false, characters: EntityConfig = EntityConfig(size: CGSize(width: 120, height: 80)), monster: EntityConfig = EntityConfig(size: CGSize(width: 120, height: 120)), spaceToMonster: CGFloat, spaceBetweenCharacters: CGFloat) {
            
            self.duration = duration
            self.delay = delay
            self.repeatForever = repeatForever
            self.reverse = reverse
            self.vertical = vertical
            self.characters = characters
            self.monster = monster
            self.spaceToMonster = spaceToMonster
            self.spaceBetweenCharacters = spaceBetweenCharacters
            
            self.initialConfig = (characters, monster, duration, delay, reverse, vertical, repeatForever)
        }
        
        func setRandomMode(_ active: Bool) {
            self.isRandomMode = active
        }
        
        func startAnimation() {
            shouldStop = false
            
            if isRandomMode {
                startRandomLoop()
            } else {
                startFixedLoop()
            }
        }
        
        func stop() {
            shouldStop = true
            isRandomMode = false
            
            withAnimation(.none) {
                self.isRunning = false
            }
        }
        
        private func startFixedLoop() {
            resetToInitial()
            
            var animation = Animation.linear(duration: duration).delay(delay)
            
            if repeatForever {
                animation = animation.repeatForever(autoreverses: false)
            }
            
            withAnimation(animation) {
                isRunning = true
            }
        }
        
        private func resetToInitial() {
            self.characters = initialConfig.chars
            self.monster = initialConfig.monster
            self.duration = initialConfig.duration
            self.delay = initialConfig.delay
            self.reverse = initialConfig.reverse
            self.vertical = initialConfig.vertical
            self.repeatForever = initialConfig.repeat
        }
        
        private func startRandomLoop() {
            guard !shouldStop else { return }
            
            withAnimation(.none) {
                self.isRunning = false
                self.generateRandomParameters()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.linear(duration: self.duration)) {
                    self.isRunning = true
                }
            }
            
            let nextRunDelay = self.duration + 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + nextRunDelay) {
                if self.isRandomMode && !self.shouldStop {
                    self.startRandomLoop()
                }
            }
        }
        
        private func generateRandomParameters() {
            duration = Double.random(in: 2.0...5.0)
            let scenario = Int.random(in: 0...3)
            let margin: CGFloat = 400
            
            var start = CGPoint.zero
            var end = CGPoint.zero
            
            let safeX = CGFloat.random(in: 50...(screenWidth - 150)) - (screenWidth / 2)
            let safeY = CGFloat.random(in: 100...(screenHeight - 200)) - (screenHeight / 2)
            
            switch scenario {
            case 0:
                vertical = false; reverse = false
                start = CGPoint(x: screenWidth + margin, y: safeY); end = CGPoint(x: -margin, y: safeY)
            case 1:
                vertical = false; reverse = true
                start = CGPoint(x: -margin, y: safeY); end = CGPoint(x: screenWidth + margin, y: safeY)
            case 2:
                vertical = true; reverse = false
                start = CGPoint(x: safeX, y: screenHeight + margin); end = CGPoint(x: safeX, y: -screenHeight - margin)
            case 3:
                vertical = true; reverse = true
                start = CGPoint(x: safeX, y: -screenHeight - margin); end = CGPoint(x: safeX, y: screenHeight + margin)
            default: break
            }
            
            self.characters = EntityConfig(size: initialConfig.chars.size, start: start, end: end)
            self.monster = EntityConfig(size: initialConfig.monster.size, start: start, end: end)
        }
        
        var femaleImageResource: ImageResource {
            switch (vertical, reverse) {
            case (false, false): return .esgiFemale
            case (false, true):  return .esgiFemaleReversed
            case (true, false):  return .esgiFemaleVertical
            case (true, true):   return .esgiFemaleVerticalReverse
            }
        }
            
        var maleImageResource: ImageResource {
            switch (vertical, reverse) {
            case (false, false): return .esgiMale
            case (false, true):  return .esgiMaleReversed
            case (true, false):  return .esgiMaleVertical
            case (true, true):   return .esgiMaleVerticalReverse
            }
        }
            
        var monsterImageResource: ImageResource {
            switch (vertical, reverse) {
            case (false, false): return .esgiMonster
            case (false, true):  return .esgiMonsterReversed
            case (true, false):  return .esgiMonsterVertical
            case (true, true):   return .esgiMonsterVerticalReverse
            }
        }
    }
}
