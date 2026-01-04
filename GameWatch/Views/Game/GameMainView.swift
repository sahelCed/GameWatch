//
//  GameMainView.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 20/12/2025.
//

import SwiftUI

import SwiftUI

struct GameMapView: View {
    @Bindable var viewModel: GameViewModel
    
    @State private var selectedStep: GameStep?
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ZStack {
                    Image(.esgiFullMap)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width, height: geo.size.height)
                
                    ForEach(viewModel.game.steps) { step in
                            let location = step.room.roomLocation
                            MapRoomView(step: step) {
                                selectedStep = step
                            }
                            .frame(
                                width: geo.size.width * location.widthRelativeToMap,
                                height: geo.size.height * location.heightRelativeToMap
                            )
                            .position(
                                x: geo.size.width * location.centerXRelativeToWidth,
                                y: geo.size.height * location.centerYRelativeToHeight
                            ) 
                    }
                }
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle(viewModel.getTimer())
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .sheet(item: $selectedStep) { step in
                RoomView(viewModel: viewModel, stepId: step.id)
            }
        }
    }
}

#Preview {
    
    GameMapView(viewModel: GameViewModel(game: GameFactory.gameFrom(difficulty: .easy, options: GameOptions(soundEnabled: true, hapticsEnabled: true, gameExplanationsEnabled: true), name: "player 1")))
}
