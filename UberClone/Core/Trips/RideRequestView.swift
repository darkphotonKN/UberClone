//
//  RideRequestView.swift
//  UberClone
//
//  Created by Kranti on 2023/12/24.
//

import Foundation
import SwiftUI

struct RideRequestView: View  {
    var shape = ShapeDimensions(height: 8, width: 8)
    var viewVerticalSpacing: CGFloat = 4 // spacing shared between each view
    var viewCornerRadius: CGFloat = 10 // corner radius for each view area
    
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel

    var body: some View {
        VStack {
            Capsule()
                .foregroundStyle(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, viewVerticalSpacing)
            
            // Trip Info View
            HStack {
                // Deco Icon
                CurrToDestIconView(startShape: shape, endShape: shape)
                    .padding(.trailing, 12)
                
                // Search Inputs
                VStack(alignment: .leading) {
                    // Current Location
                    HStack {
                        if let pickupTime = locationSearchViewModel.rideTimes?.pickupTime {
                            Text("Current Location")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.gray)
                            Spacer()
                            Text(pickupTime)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Spacer().frame(maxHeight: 27)
                    
                    // Destination Location
                    HStack {
                        if let destLocationTitle = locationSearchViewModel.selectedLocation?.title, let dropoffTime = locationSearchViewModel.rideTimes?.dropoffTime {
                            Text(destLocationTitle)
                                .font(.system(size: 16, weight: .semibold))
                            Spacer()
                            Text(dropoffTime)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.gray)
                        } else {
                            // shows while location is searching
                            Text("")
                                .font(.system(size: 16, weight: .semibold))
                            Spacer()
                            Text("")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.gray)
                        }
                            
                    }
                    
                }
                .padding(.leading, 5)
            }.padding()
            
            Divider()
            
            VStack {
                // Ride Type Selection View
                SuggestedRidesSelectionView(cornerRadius: viewCornerRadius)
                    .padding(.vertical, viewVerticalSpacing)
                
                // Payment Option View
                PaymentOptionView(cornerRadius: viewCornerRadius)
                    .padding(.vertical, viewVerticalSpacing)
                
                // Request Ride Button
                // Confirm Selection Button
                Button {
                    
                } label: {
                    Text("CONFIRM RIDE")
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.vertical)
                        .background(.blue)
                        .cornerRadius(viewCornerRadius)
                }
                .padding(.vertical, viewVerticalSpacing)
                
            }
            .padding([.leading, .trailing], 20)
            .padding([.top, .bottom], 10)
        }
        .padding(.bottom, 15)
        .background(Color.colorTheme.bgColor)
        .cornerRadius(10)
       
    }
}

#Preview {
    RideRequestView()
}
