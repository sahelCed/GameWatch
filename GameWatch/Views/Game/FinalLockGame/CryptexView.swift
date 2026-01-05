//
//  CryptexView.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 05/01/2026.
//

import SwiftUI

struct CryptexView: View {
    @Binding var selection: [Major]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    LinearGradient(colors: [
                        Color(red: 0.3, green: 0.2, blue: 0.1),
                        Color(red: 0.6, green: 0.4, blue: 0.2),
                        Color(red: 0.3, green: 0.2, blue: 0.1)
                    ], startPoint: .top, endPoint: .bottom)
                )
                .frame(height: 220)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.orange.opacity(0.3), lineWidth: 2)
                )
                .shadow(color: .black.opacity(0.8), radius: 10, x: 0, y: 10)
        
            Rectangle()
                .fill(
                    LinearGradient(colors: [
                        .yellow.opacity(0.1),
                        .orange.opacity(0.3),
                        .yellow.opacity(0.1)
                    ], startPoint: .top, endPoint: .bottom)
                )
                .frame(height: 35)
                .overlay(
                    Rectangle()
                        .stroke(Color.yellow.opacity(0.5), lineWidth: 1)
                )
                .padding(.horizontal, 5)
                .allowsHitTesting(false)
            
            HStack(spacing: 0) {
                ForEach(0..<selection.count, id: \.self) { index in
                    Picker("", selection: $selection[index]) {
                        ForEach(Major.allCases, id: \.self) { major in
                            Text(major.rawValue)
                                .font(.caption2)
                                .foregroundStyle(.white)
                                .font(.system(size: 10, weight: .light, design: .rounded))
                                .minimumScaleFactor(0.3)
                                .lineLimit(1)
                                .tag(major)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 200)
                    .clipped()
                }
            }
        }
        
    }
}

#Preview {
    @Previewable @State var testSelection: [Major] = Major.allCases
    
    ZStack {
        Color.black.ignoresSafeArea()
        CryptexView(selection: $testSelection)
    }
}
