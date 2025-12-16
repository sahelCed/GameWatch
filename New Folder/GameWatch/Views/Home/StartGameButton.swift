//
//  StartGameButton.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 09/12/2025.
//

import SwiftUI

struct StartGameButton: View {
    var isConnected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "flag.pattern.checkered")
                Text("Commencer une partie")
                Image(systemName: "flag.pattern.checkered")
            }
        }
        .buttonStyle(.glassProminent)
        .tint(.teal.opacity(isConnected ? 1 : 0.1))
        .disabled(!isConnected)
    }
}

#Preview {
    StartGameButton(isConnected: true, action: {})
}
