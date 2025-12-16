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
        ZStack {
            Color.black.ignoresSafeArea()
            Image(.logo)
                .resizable()
                .scaledToFill()
                .opacity(viewModel.isPulsing ? 0.33 : 1)
                .ignoresSafeArea()
            

            Text("Waiting for game...")
                .foregroundColor(.red)
                .font(.largeTitle)
                .bold()
                .buttonBorderShape(.capsule)
                .padding()
                .opacity(viewModel.isPulsing ? 1 : 0.1)
                .ignoresSafeArea()
        }
        .onAppear {
            withAnimation(
                .easeInOut(duration: 5.0)
                .repeatForever(autoreverses: true)
            ) {
                viewModel.isPulsing = true
            }
        } 
    }
}

#Preview {
    HomeView()
}
