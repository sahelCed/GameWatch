//
//  HomeView.swift
//  GameWatch
//
//  Created by Gil Linhares on 02/12/2025.


import SwiftUI

struct HomeView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                HomeBackgroundView()
                
                VStack {
                    HomeHeaderView()
                    
                    HomeActionsView(viewModel: viewModel)
                    
                    Spacer()
                    
                    StartGameButton(isConnected: viewModel.isWatchConnected) {
                        
                        if viewModel.isWatchConnected {
                            viewModel.presentingCreateGame.toggle()
                        }
                    }
                    .padding(.bottom, 40)
                    .sheet(isPresented: $viewModel.presentingCreateGame) {
                        CreateGameView()
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
