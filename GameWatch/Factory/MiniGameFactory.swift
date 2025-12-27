//
//  MiniGameFactory.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 21/12/2025.
//

class MiniGameFactory {
    
    private static let failedSearchMessages = [
        "Vous avez retourné la pièce sans succès...",
        "Cette zone semble n'avoir aucun intérêt stratégique...",
        "Fausse piste ! Il n'y a rien d'intéréssant ici...",
        "Vous avez perdu du temps, cette salle est ne contient rien d'intéréssant...",
        "Malgré une fouille minutieuse, le résultat est décevant...",
        "Mauvaise pioche, Sananes n'est pas passé par ici...",
        "Rien à signaler. La voie est libre, mais vide...",
        "Circulez, il n'y a rien à voir d'important..."
    ]
    
    static func miniGameFrom(miniGameType: MiniGameType) -> MiniGame {
        switch miniGameType {
        case .search:
            let name = failedSearchMessages.randomElement()
            let instruction = "Essayez une autre salle."
            return MiniGame(name: name!, instruction: instruction, isCompleted: false, type: .search, image: "empty_room")
        case .simonSays:
            let name = "Un étrange mécanisme à couleur"
            let instruction = "Répétez les séquences sur votre montre."
            return MiniGame(name: name, instruction: instruction, isCompleted: false, type: .simonSays, image: "simon_image")
        case .finalLock:
            let name = "Le tiroir secret du tyran"
            let instruction = "Entrez le code pour dévérouiller le tiroir."
            return MiniGame(name: name, instruction: instruction, isCompleted: false, type: .finalLock, image: "drawer_lock")
        case .exit:
            let name = "Porte de l'ESGI"
            let instruction = "Utilisez la clé pour sortir."
            return MiniGame(name: name, instruction: instruction, isCompleted: false, type: .exit, image: "exit_lock")
        }
    }
}
