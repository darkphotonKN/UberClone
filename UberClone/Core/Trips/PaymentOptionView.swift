//
//  PaymentOptionView.swift
//  UberClone
//
//  Created by Kranti on 2023/12/26.
//

import Foundation
import SwiftUI

struct PaymentOptionView: View {
    var cornerRadius: CGFloat
    
    var body: some View {
        VStack {
            HStack {
                // Visa Icon
                Text("Visa")
                    .foregroundStyle(.white)
                    .font(.system(size: 12, weight: .semibold))
                    .padding(.vertical, 4)
                    .padding(.horizontal, 6)
                    .background(.blue)
                    .cornerRadius(4)
                // Credit Card Info
                Text("**** 8888")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                // Payment Selection Arrow
                Image(systemName: "arrowtriangle.right")
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .background(Color.colorTheme.secondaryBgColor)
        .cornerRadius(cornerRadius)
        
    }
}

#Preview {
    PaymentOptionView(cornerRadius: 10)
}
