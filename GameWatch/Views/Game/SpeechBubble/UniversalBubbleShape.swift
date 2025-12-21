//
//  UniversalBubbleShape.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 20/12/2025.
//

import SwiftUI

struct UniversalBubbleShape: Shape {
    var direction: BubbleDirection = .bottom
    var tailPosition: CGFloat = 0.5
    var tailWidth: CGFloat = 20
    var tailLength: CGFloat = 15
    var cornerRadius: CGFloat = 15
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let bubbleRect: CGRect
        
        switch direction {
        case .top:
            bubbleRect = CGRect(x: 0, y: tailLength, width: rect.width, height: rect.height - tailLength)
        case .bottom:
            bubbleRect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height - tailLength)
        case .left:
            bubbleRect = CGRect(x: tailLength, y: 0, width: rect.width - tailLength, height: rect.height)
        case .right:
            bubbleRect = CGRect(x: 0, y: 0, width: rect.width - tailLength, height: rect.height)
        }
        
        path.addRoundedRect(in: bubbleRect, cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
        
        switch direction {
        case .top:
            let startX = bubbleRect.minX + (bubbleRect.width * tailPosition)
            path.move(to: CGPoint(x: startX - (tailWidth / 2), y: bubbleRect.minY))
            path.addLine(to: CGPoint(x: startX, y: rect.minY)) // Pointe vers le haut (0)
            path.addLine(to: CGPoint(x: startX + (tailWidth / 2), y: bubbleRect.minY))
            
        case .bottom:
            let startX = bubbleRect.minX + (bubbleRect.width * tailPosition)
            path.move(to: CGPoint(x: startX - (tailWidth / 2), y: bubbleRect.maxY))
            path.addLine(to: CGPoint(x: startX, y: rect.maxY)) // Pointe vers le bas
            path.addLine(to: CGPoint(x: startX + (tailWidth / 2), y: bubbleRect.maxY))
            
        case .left:
            let startY = bubbleRect.minY + (bubbleRect.height * tailPosition)
            path.move(to: CGPoint(x: bubbleRect.minX, y: startY - (tailWidth / 2)))
            path.addLine(to: CGPoint(x: rect.minX, y: startY)) // Pointe vers la gauche
            path.addLine(to: CGPoint(x: bubbleRect.minX, y: startY + (tailWidth / 2)))
            
        case .right:
            let startY = bubbleRect.minY + (bubbleRect.height * tailPosition)
            path.move(to: CGPoint(x: bubbleRect.maxX, y: startY - (tailWidth / 2)))
            path.addLine(to: CGPoint(x: rect.maxX, y: startY)) // Pointe vers la droite
            path.addLine(to: CGPoint(x: bubbleRect.maxX, y: startY + (tailWidth / 2)))
        }
        
        return path
    }
}
