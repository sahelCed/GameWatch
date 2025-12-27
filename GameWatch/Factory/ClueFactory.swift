//
//  ClueFactory.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 17/12/2025.
//

struct ClueFactory {
    
    private static let uselessCluesData: [(text: String, image: String?)] = [
        ("Il semblerait que vous soyez tombé sur sa routine capillaire... C'est un papier vide.", "capilar_routine"),
        ("Dommage, encore des paires de lunettes de rechange... Mais combien en a-t-il ????", "replacement_glasses"),
        ("Un ticket de caisse pour 50 litres de café. Date : Hier.", "coffee_receipt"),
        ("Une note griffonnée : 'Idée de punition : Faire coder en assembleur sur papier'.", "punishement_idea"),
        ("Une photo de vacances...", "vacation_picture"),
        ("Un plan pour conquérir le monde... raturé et remplacé par 'Terroriser les nouvelles rentrée'.", "world_domination")
    ]
    
    static func generateUselessClue() -> Clue {
        
        let data = uselessCluesData.randomElement() ?? ("Rien à signaler ici.", nil)
            
        return Clue(
            text: data.text,
            image: data.image
        )
    }
 
    static func generateClues(from secretCode: [Major]) -> [Clue] {
            var generatedClues: [Clue] = []
            let firstMajor = secretCode[0]
            let clue1 = Clue(
                text: "C'est officiel : Sananes a déclaré que la filière \(firstMajor.fullName) est la numéro 1 cette année !",
                image: "trophy_\(firstMajor.rawValue)"
            )
            generatedClues.append(clue1)
            
            let second = secretCode[1]
            let third = secretCode[2]
            let clue2 = Clue(
                text: "Dans le classement, la filière \(second.rawValue) est juste devant la filière \(third.rawValue).",
                image: nil
            )
        
            generatedClues.append(clue2)
        
            if let lastMajor = secretCode.last {
                let clueLast = Clue(
                    text: "Mauvaise nouvelle... La filière \(lastMajor.fullName) a fini dernière du classement.",
                    image: "poubelle_generic"
                )
                generatedClues.append(clueLast)
            }
            
            let middleMajor1 = secretCode[4]
            let middleMajor2 = secretCode[5]
            let clueMiddle = Clue(
                text: "Rumeur de couloir : Les emplois du temps de \(middleMajor1.rawValue) et \(middleMajor2.rawValue) se suivent de près.",
                image: nil
            )
            generatedClues.append(clueMiddle)
        
            return generatedClues.shuffled()
        }
    
}
