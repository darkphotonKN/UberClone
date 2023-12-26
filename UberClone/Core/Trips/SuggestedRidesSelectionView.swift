//
//  SuggestedRidesSelectionView.swift
//  UberClone
//
//  Created by Kranti on 2023/12/25.
//

import Foundation
import SwiftUI

struct SuggestedRidesSelectionView: View {
    var cornerRadius: CGFloat
    
    var body: some View {
        VStack {
            // Title
            HStack {
                Text("SUGGESTED RIDES")
                    .foregroundStyle(.gray)
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
            }
            // Rides
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    // Iterate through all suggested rides, offering scroll
                    // for off-screen options
                    ForEach(0..<3, id: \.self) { _ in
                        VStack {
                            VStack {
                                // Vehicle Image
                                Image("uber-x")
                                    .resizable()
                                    .scaledToFit()
                                HStack {
                                    VStack {
                                        // Name of Vehicle
                                        Text("Uber-X")
                                            .font(.system(size: 14, weight: .semibold))
                                        // Pricing
                                        Text("$22.04")
                                            .font(.system(size: 14, weight: .semibold))
                                    }
                                    Spacer()
                                }.padding(10)
                                
                            }
                            .frame(width: 110, height: 144)
                            .background(Color(.systemGroupedBackground))
                            .cornerRadius(cornerRadius)
                       
                        }
                    }
                }
            }
            
        }
    }
}

#Preview {
    SuggestedRidesSelectionView(cornerRadius: 10)
}
