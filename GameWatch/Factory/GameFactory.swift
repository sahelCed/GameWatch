//
//  GameFactory.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 17/12/2025.
//

import Foundation

class GameFactory {

    static func gameFrom(difficulty: GameDifficulty, options: GameOptions, name: String) -> Game {
        let secretCode = SecretCodeFactory.generate()
        var clues = ClueFactory.generateClues(from: secretCode)
        
        let duration: TimeInterval
        let penality: Double
        
        switch difficulty {
            case .easy:
                duration = .minutes(5)
                penality = 0
            case .medium:
                duration = .minutes(3)
                penality = 10
            case .hard:
                duration = .minutes(2)
                penality = 30
        }
        
        let steps = generateSteps(
            clues: &clues
        )
                
        return Game(
            duration: duration,
            name: name,
            steps: steps,
            secretCode: secretCode,
            options: options,
            penality: penality
        )
    }
    
    
    private static func generateSteps(clues: inout [Clue]) -> [GameStep] {
        var steps: [GameStep] = []
        let shuffledRooms = RoomsRepository.playableRooms.shuffled()
        
        for room in shuffledRooms {
            
            let clue: Clue
            let miniGame: MiniGame
            
            if !clues.isEmpty {
                clue = clues.removeFirst()
                let randomGameType = MiniGameType.playableGames.randomElement()!
                miniGame = MiniGameFactory.miniGameFrom(miniGameType: randomGameType)
            } else {
                clue = ClueFactory.generateUselessClue()
                miniGame = MiniGameFactory.miniGameFrom(miniGameType: .search)
            }
            
            let step = GameStep(
                miniGame: miniGame,
                room: room,
                rewardClue: clue
            )
            steps.append(step)
        }
        
        let finalMiniGame = MiniGameFactory.miniGameFrom(miniGameType: .finalLock)
        let finalStep = GameStep(
            miniGame: finalMiniGame,
            room: RoomsRepository.bureauSananes,
            rewardClue: Clue(text: "Vous avez obtenu la clé de la porte ! Vous pouvez désormais vous échapper.")
        )
        steps.append(finalStep)
        
        let exitMiniGame = MiniGameFactory.miniGameFrom(miniGameType: .exit)
        let exitStep = GameStep(
            miniGame: exitMiniGame,
            room: RoomsRepository.exit,
            rewardClue: Clue(text: "")
        )
        steps.append(exitStep)
        
        return steps
    }
}
