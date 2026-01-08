//
//  SimonSaysViewModel.swift
//  GameWatch
//
//  Created by Cedric Ait sahel on 07/01/2026.
//

import Foundation

extension SimonSaysView {
    @Observable
    class ViewModel {
        private let connectivity: Connectivity
        var sequence: [SimonColor] = []
        var playerInput: [SimonColor] = []
        var isShowingSequence = false
        var level = 0
        var gameOver = false
        var currentSimonColor = nil as SimonColor?
        var start = false
        
            
        init(connectivity: Connectivity = .shared) {
            self.connectivity = connectivity
        }
        
        func startGame(){
            self.start = true
            initGame()
            showSequence()
        }
        
        
        func initGame(){
            for _ in 0..<5 {
                addNewColor()
            }
        }
        
        var isWatchConnected: Bool {
            connectivity.watchConnected
        }
                
        
        func checkConnection() {
            connectivity.checkConnection()
        }
        
        
        private func addNewColor() {
            guard let randomColor = SimonColor.allCases.randomElement() else { return }
            sequence.append(randomColor)
            level = sequence.count
        }
        
        private func showSequence() {
            isShowingSequence = true
            var delay: Double = 0

            for color in sequence {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    self.currentSimonColor = color
                }
                delay += 3
            }

            // Remet à nil la couleur après la séquence
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.currentSimonColor = nil
                self.isShowingSequence = false
            }
        }
    }
}
