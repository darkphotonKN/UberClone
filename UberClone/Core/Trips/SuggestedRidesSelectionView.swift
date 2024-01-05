//
//  SuggestedRidesSelectionView.swift
//  UberClone
//
//  Created by Kranti on 2023/12/25.
//

import Foundation
import SwiftUI

struct SuggestedRidesSelectionView: View {
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
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
                                    VStack(alignment: .leading) {
                                        // Name of Vehicle
                                        Text(ride.description)
                                            .font(.system(size: 14, weight: .semibold))
                                        // Pricing
                                        Text(locationSearchViewModel.calcRidePrice(rideType: ride).toCurrency())
//                                        Text("$12.22")
                                            .font(.system(size: 14, weight: .semibold))
                                    }
                                    Spacer()
                                }.padding(10)
                                
                            }
                            .frame(width: 110, height: 144)
                            .scaleEffect(ride == selectedRide ? 1.05 : 1)
                            .foregroundStyle(ride == selectedRide ? .white : Color.colorTheme.textColor)
                            .background(ride == selectedRide ? Color(.systemBlue) : Color.colorTheme.secondaryBgColor)
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
