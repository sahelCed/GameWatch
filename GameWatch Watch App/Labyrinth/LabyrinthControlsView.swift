//
//  LabyrinthControlsView.swift
//  GameWatch
//
//  Created by Gilberto Pires da Silva Filho on 02/01/2026.
//

import SwiftUI

struct LabyrinthControlsView: View {
    private let connectivity: Connectivity = .shared
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Labyrinthe")
                .font(.headline)
            
            LabyrinthControlPadView { direction in
                send(direction)
            }
        }
        .padding()
    }
    
    private func send(_ direction: LabyrinthControlDirection) {
        connectivity.send([
            LabyrinthMessageKeys.action: LabyrinthMessageKeys.moveAction,
            LabyrinthMessageKeys.direction: direction.rawValue
        ])
        NotificationCenter.default.post(
            name: .labyrinthMove,
            object: nil,
            userInfo: [LabyrinthMessageKeys.direction: direction.rawValue]
        )
    }
}

#Preview {
    LabyrinthControlsView()
}
