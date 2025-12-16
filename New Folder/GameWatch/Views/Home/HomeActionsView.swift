//
//  HomeActionsView.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 09/12/2025.
//

import SwiftUI

struct HomeActionsView: View {
    var viewModel: HomeView.ViewModel
        
        var body: some View {
            VStack(spacing: 60) {
                Button {
                    viewModel.checkConnection()
                } label: {
                    VStack {
                        Image(systemName: viewModel.isWatchConnected ? "checkmark.applewatch" : "applewatch.slash")
                            .font(.system(size: 40, weight: .medium))
                            .frame(height: 60)
                        Text(viewModel.isWatchConnected ? "Connected" : "Connect watch")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                    .padding(.top)
                    .padding()
                }
                .buttonStyle(.glassProminent)
                .buttonBorderShape(.roundedRectangle)
                .tint(.teal)
                .padding(.top, 54)
                
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "flag.pattern.checkered.2.crossed")
                        Text("Leaderboards")
                        Image(systemName: "flag.pattern.checkered.2.crossed")
                    }
                }
                .buttonStyle(.glassProminent)
                .tint(.teal)
            }
        }
    }

#Preview {
    HomeActionsView(viewModel: HomeView.ViewModel.init())
}
