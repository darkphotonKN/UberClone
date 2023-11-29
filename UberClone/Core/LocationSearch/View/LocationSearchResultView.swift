//
//  LocationSearchResultView.swift
//  UberClone
//
//  Created by Kranti on 2023/11/30.
//

import SwiftUI

struct LocationSearchResultView: View {
    var title: String
    var address: String
    
    var body: some View {
        
            VStack {
                HStack {
                    // (Left) Map Icon
                    Image(systemName: "mappin.circle.fill")
                        .resizable()
                        .foregroundColor(.blue)
                        .accentColor(.white)
                        .frame(width: 40, height: 40)
                        .padding(.trailing, 8)
                    
                    // (Right) Title and Address
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.system(size: 22, weight: .medium))
                        Text(address)
                            .font(.system(size: 18, weight: .light))
                            .foregroundStyle(.gray)
                        
                    }
                    Spacer()
                }.padding(.bottom, 20)
                    .padding(.leading, 15)
                
                Divider()
                
            }
       
    }
}

#Preview {
    LocationSearchResultView(title: "Starbucks Coffee", address: "12th Southville Boulevard, New York")
}
