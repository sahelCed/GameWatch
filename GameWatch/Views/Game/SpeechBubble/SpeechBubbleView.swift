//
//  SpeechBubbleView.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 20/12/2025.
//

import SwiftUI

import SwiftUI
internal import Combine

struct SpeechBubbleView: View {
    // Le texte complet avec ses attributs (gras, etc.)
    let fullText: AttributedString
    
    @State private var displayedText: AttributedString = ""
    
    var direction: BubbleDirection = .bottom
    var tailPosition: CGFloat = 0.5
    var color: Color = .white
    
    @State private var characterIndex = 0
    let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()
    @State private var isFinished = false
    
    init(text: String, direction: BubbleDirection = .bottom, tailPosition: CGFloat = 0.5) {
        self.direction = direction
        self.tailPosition = tailPosition
        
        if let attributed = try? AttributedString(markdown: text, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)) {
            self.fullText = attributed
        } else {
            self.fullText = AttributedString(text)
        }
    }

    var body: some View {
        Text(displayedText)
            .font(.body)
            .multilineTextAlignment(.center)
            .padding()
            .background(
                UniversalBubbleShape(direction: direction, tailPosition: tailPosition)
                    .fill(color)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
            )
            .padding(edgeForDirection(direction), 15)
            .onReceive(timer) { _ in
                if isFinished {
                    timer.upstream.connect().cancel()
                    return
                }
                
                if characterIndex < fullText.characters.count {
                    let index = fullText.characters.index(fullText.startIndex, offsetBy: characterIndex)
                    displayedText.append(fullText[index...index])
                    characterIndex += 1
                } else {
                    isFinished = true
                }
            }
            .onTapGesture {
                if !isFinished {
                    displayedText = fullText
                    isFinished = true
                    timer.upstream.connect().cancel()
                }
            }
    }
    
    func edgeForDirection(_ dir: BubbleDirection) -> Edge.Set {
        switch dir {
        case .top: return .top
        case .bottom: return .bottom
        case .left: return .leading
        case .right: return .trailing
        }
    }
}

#Preview {
    SpeechBubbleView(text: "Wow c'est une super bulle &éee&e& e é&e &e&é eeé& e&ee&éé& e")
}
