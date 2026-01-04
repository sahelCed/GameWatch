//
//  LabyrinthControlsView.swift
//  GameWatch
//
//  Created by Gilberto Pires da Silva Filho on 02/01/2026.
//

import SwiftUI

struct LabyrinthControlsView: View {
    private let connectivity: Connectivity = .shared
    
    private enum WatchDirection: String {
        case up, down, left, right
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Labyrinthe")
                .font(.headline)
            controlPad
        }
        .padding()
    }
    
    private var controlPad: some View {
        VStack(spacing: 8) {
            Button { send(.up) } label: {
                Image(systemName: "chevron.up")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            HStack(spacing: 8) {
                Button { send(.left) } label: {
                    Image(systemName: "chevron.left")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                Button { send(.right) } label: {
                    Image(systemName: "chevron.right")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            Button { send(.down) } label: {
                Image(systemName: "chevron.down")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    private func send(_ direction: WatchDirection) {
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
