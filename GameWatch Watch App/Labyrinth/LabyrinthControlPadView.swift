//
//  LabyrinthControlPadView.swift
//  GameWatch
//
//  Created by Gilberto Pires da Silva Filho on 04/01/2026.
//

import SwiftUI

struct LabyrinthControlPadView: View {
    let onDirectionTapped: (LabyrinthControlDirection) -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Button { onDirectionTapped(.up) } label: {
                Image(systemName: "chevron.up")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            
            HStack(spacing: 8) {
                Button { onDirectionTapped(.left) } label: {
                    Image(systemName: "chevron.left")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                
                Button { onDirectionTapped(.right) } label: {
                    Image(systemName: "chevron.right")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            
            Button { onDirectionTapped(.down) } label: {
                Image(systemName: "chevron.down")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

enum LabyrinthControlDirection: String {
    case up, down, left, right
}

#Preview {
    LabyrinthControlPadView { direction in
        print("Direction: \(direction)")
    }
    .padding()
}
