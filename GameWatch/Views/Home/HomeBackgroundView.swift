//
//  HomeBackgroundView.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 09/12/2025.
//

import SwiftUI

struct HomeBackgroundView: View {
    
    var body: some View {
            
        BackgroundAnimationView(
            characters: EntityConfig(size: CGSize(width: 120, height: 80)),
            monster: EntityConfig(size: CGSize(width: 120, height: 120))
        )
        .randomLoop()
    }
}

#Preview {
    HomeBackgroundView()
}
