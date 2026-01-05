//
//  FinalLockViewModel.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 05/01/2026.
//

import Foundation
import SwiftUI

extension FinalLockView {
    @Observable
    class ViewModel {
        let secretCode: [Major]
        var cryptexCode: [Major]
        var penalityApplied: Bool = false
        
        init(secretCode: [Major]) {
            self.secretCode = secretCode
            self.cryptexCode = Major.allCases.shuffled()
        }
        
        func validateCode() -> Bool {
            return cryptexCode == secretCode
        }
    }
}
