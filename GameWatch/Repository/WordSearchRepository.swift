//
//  WordSearchRepository.swift
//  GameWatch
//
//  Created by Auto on 07/01/2026.
//

import Foundation

struct WordSearchRepository {
    static let availableWords: [String] = [
        "ESGI",
        "CODE",
        "ALGORITHME",
        "SANANES",
        "PROJET",
        "EXAMEN",
        "STUDENT",
        "CAMPUS"
    ]
    
    static func generateGrid(words: [String], size: Int = 10) -> [[Character]] {
        var grid = Array(repeating: Array(repeating: Character(" "), count: size), count: size)
        
        var placedWords: [String] = []
        var attempts = 0
        let maxAttempts = 100
        
        for word in words.shuffled() {
            let upperWord = word.uppercased().replacingOccurrences(of: " ", with: "")
            guard upperWord.count <= size && upperWord.count > 0 else { continue }
            
            var placed = false
            attempts = 0
            
            while !placed && attempts < maxAttempts {
                let row = Int.random(in: 0..<size)
                let col = Int.random(in: 0...(size - upperWord.count))
                
                var canPlace = true
                for (index, char) in upperWord.enumerated() {
                    let currentChar = grid[row][col + index]
                    if currentChar != " " && currentChar != char {
                        canPlace = false
                        break
                    }
                }
                
                if canPlace {
                    for (index, char) in upperWord.enumerated() {
                        grid[row][col + index] = char
                    }
                    placedWords.append(upperWord)
                    placed = true
                }
                
                attempts += 1
            }
        }
        
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        for i in 0..<size {
            for j in 0..<size {
                if grid[i][j] == " " {
                    grid[i][j] = letters.randomElement() ?? "A"
                }
            }
        }
        
        return grid
    }
}

