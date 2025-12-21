//
//  SecretCodeFactory.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 17/12/2025.
//

import Foundation

struct SecretCodeFactory {
    /// Génère l'ordre des filières selon les règles du Tyran Sananes
    static func generate() -> [Major] {
        let top3: [Major] = [.MOC, .AL, .SI].shuffled()
        
        let bottom2: [Major] = [.BC, .MCSI].shuffled()
        
        let used = Set(top3 + bottom2)
        
        let middle4 = Major.allCases.filter { !used.contains($0) }.shuffled()
        
        return top3 + middle4 + bottom2
    }
}
