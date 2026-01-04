//
//  ContentView.swift
//  GameWatch Watch App
//
//  Created by Yanis Lammari on 02/12/2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                ZStack {
                    Color.black.ignoresSafeArea()
                    Image("logo.png")
                        .resizable()
                        .scaledToFill()
                        .opacity(viewModel.isPulsing ? 0.33 : 1)
                        .ignoresSafeArea()
                    Text("Waiting for game...")
                        .foregroundColor(.red)
                        .font(.title2.bold())
                        .padding()
                        .opacity(viewModel.isPulsing ? 1 : 0.1)
                        .ignoresSafeArea()
                }
                .frame(height: 120)
                
                NavigationLink {
                    LabyrinthControlsView()
                } label: {
                    Text("Contrôles Labyrinthe")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
            }
            .onAppear {
                withAnimation(
                    .easeInOut(duration: 5.0)
                    .repeatForever(autoreverses: true)
                ) {
                    viewModel.isPulsing = true
                }
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
