//
//  DifficultyPickerView.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 17/12/2025.
//

import SwiftUI

struct DifficultyPickerView: View {
    @Binding var selectedDifficulty: GameDifficulty
        var body: some View {
            HStack(spacing: 0) {
                ForEach(GameDifficulty.allCases, id: \.self) { difficulty in
                    
                    Button {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            selectedDifficulty = difficulty
                        }
                    } label: {
                        Text(difficulty.title)
                            .font(.subheadline.bold())
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(
                                selectedDifficulty == difficulty ? difficulty.color : Color.black.opacity(0.2)
                            )
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(.plain)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.white.opacity(0.2), lineWidth: 1)
            )
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
}

#Preview {
    DifficultyPickerView(selectedDifficulty: .constant(.hard))
}
