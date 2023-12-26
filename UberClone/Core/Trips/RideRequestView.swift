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
    
    var body: some View {
        VStack {
            Capsule()
                .foregroundStyle(Color(.systemGray5))
                .frame(width: 48, height: 6)
            
            // Trip Info View
            HStack {
                // Deco Icon
                CurrToDestIconView(startShape: shape, endShape: shape)
                    .padding(.trailing, 12)
                
                // Search Inputs
                VStack(alignment: .leading) {
                    // Current Location
                    HStack {
                        Text("Current Location")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.gray)
                        Spacer()
                        Text("1:30 PM")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 9)
                    .padding(.top, 1)
                    // Destination Location
                    HStack {
                        Text("Starbucks Coffee")
                            .font(.system(size: 16, weight: .semibold))
                        
                        Spacer()
                        Text("1:47 PM")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 11)
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
                        .font(.system(size: 18, weight: .semibold))
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
        .background(.white)
    }
}

#Preview {
    RideRequestView()
}
