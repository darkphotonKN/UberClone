//
//  LocationSearchView.swift
//  UberClone
//
//  Created by Kranti on 2023/11/28.
//

import SwiftUI

struct LocationSearchView: View {
    var body: some View {
        // search bar
        HStack {
            HStack {
                Rectangle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(.black)
                    .padding(.trailing, 14)
                
                Text("Please enter target destination.")
                Spacer()
            }.padding([.leading, .trailing], 12)
        }
        // grabs the width of rectangle then makes it slightly smaller to account
        // for the padding
        .frame(width: UIScreen.main.bounds.width - 64, height: 50)
        .background(
            // limit background styling to the rectangle and not all children inside 
            Rectangle()
                .foregroundColor(.white)
                .shadow(color: .black, radius: 5)
        )
       
        
    }
}

#Preview {
    LocationSearchView()
}
