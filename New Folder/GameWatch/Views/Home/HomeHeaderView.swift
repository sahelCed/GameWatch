//
//  HomeHeaderView.swift
//  GameWatch
//
//  Created by Gil Rodrigues on 09/12/2025.
//

import SwiftUI

struct HomeHeaderView: View {
    var body: some View {
        VStack {
            Text("ESCAPE ESGI")
                .font(.largeTitle)
                .fontDesign(.rounded)
                .foregroundStyle(.teal)
                .padding()
            
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, minHeight: 0, maxHeight: 200)
                .padding()
                .clipShape(.capsule)
        }
    }
}

#Preview {
    HomeHeaderView()
}
