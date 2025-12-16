//
//  BackgroundAnimationView.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 04/12/2025.
//

import SwiftUI

struct BackgroundAnimationView: View {
    
    @State private var viewModel: ViewModel
    
    private var randomMode: Bool = false
    
    init(
        duration: Double = 2.0,
        delay: Double = 0.0,
        repeatAnimation: Bool = false,
        reverse: Bool = true,
        vertical: Bool = false,
        characters: EntityConfig = .init(start: CGPoint(x: -400, y: 0), end: CGPoint(x: 400, y: 0)),
        monster: EntityConfig = .init(start: CGPoint(x: -400, y: 0), end: CGPoint(x: 400, y: 0)),
        spaceToMonster: CGFloat = 40,
        spaceBetweenCharacters: CGFloat = -60
    ) {
        let vm = ViewModel(
            duration: duration,
            delay: delay,
            repeatForever: repeatAnimation,
            reverse: reverse,
            vertical: vertical,
            characters: characters,
            monster: monster,
            spaceToMonster: spaceToMonster,
            spaceBetweenCharacters: spaceBetweenCharacters
        )
        _viewModel = State(initialValue: vm)
    }
    
    var body: some View {
        
        let layout = viewModel.vertical ? AnyLayout(VStackLayout(spacing: viewModel.spaceToMonster)) : AnyLayout(HStackLayout(spacing: viewModel.spaceToMonster))
        
        layout {
            HStack(spacing: viewModel.spaceBetweenCharacters) {
                Image(viewModel.femaleImageResource)
                    .resizable()
                    .frame(width: viewModel.characters.size.width, height: viewModel.characters.size.height)
                Image(viewModel.maleImageResource)
                    .resizable()
                    .frame(width: viewModel.characters.size.width, height: viewModel.characters.size.height)
            }
            .offset(x: viewModel.isRunning ? viewModel.characters.end.x : viewModel.characters.start.x,
                    y: viewModel.isRunning ? viewModel.characters.end.y : viewModel.characters.start.y)
            
            Image(viewModel.monsterImageResource)
                .resizable()
                .frame(width: viewModel.monster.size.width, height: viewModel.monster.size.height)
                .offset(x: viewModel.isRunning ? viewModel.monster.end.x : viewModel.monster.start.x,
                        y: viewModel.isRunning ? viewModel.monster.end.y : viewModel.monster.start.y)
        }
        .onAppear {
            if randomMode {
                viewModel.setRandomMode(true)
            }
            viewModel.startAnimation()
        }
        .onDisappear {
            viewModel.stop()
        }
    }
    
    func randomLoop() -> BackgroundAnimationView {
        var copy = self
        copy.randomMode = true
        return copy
    }
}

#Preview {
    BackgroundAnimationView(
        duration: 2.0,
        delay: 2.0,
        reverse: false,
        vertical: false,
        characters: EntityConfig(),
        monster: EntityConfig(),
        spaceToMonster: 40,
        spaceBetweenCharacters: -60
    )
}
