//
//  SuggestedRidesSelectionView.swift
//  UberClone
//
//  Created by Kranti on 2023/12/25.
//

import Foundation
import SwiftUI

struct SuggestedRidesSelectionView: View {
    @State private var selectedRide: RideType = .uberX
    var cornerRadius: CGFloat
    
    var body: some View {
        VStack {
            Text("")
                
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
                    ForEach(RideType.allCases) { ride in
                        
                        // MARK: Single Ride Block
                        VStack {
                            VStack {
                                // Vehicle Image
                                Image(ride.imageName)
                                    .resizable()
                                    .scaledToFit()
                                HStack {
                                    VStack {
                                        // Name of Vehicle
                                        Text(ride.description)
                                            .font(.system(size: 14, weight: .semibold))
                                        // Pricing
                                        Text("$22.04")
                                            .font(.system(size: 14, weight: .semibold))
                                    }
                                    Spacer()
                                }.padding(10)
                                
                            }
                            .frame(width: 110, height: 144)
                            .scaleEffect(ride == selectedRide ? 1.1 : 1)
                            .foregroundStyle(ride == selectedRide ? .white : .black)
                            .background(Color(ride == selectedRide ? .systemBlue : .systemGroupedBackground))
                            .cornerRadius(cornerRadius)
                       
                        }.onTapGesture {
                            withAnimation(.spring()) {
                                selectedRide = ride
                            }
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
