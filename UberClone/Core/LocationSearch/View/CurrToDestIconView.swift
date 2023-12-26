//
//  CurrToDestIconView.swift
//  UberClone
//
//  Created by Kranti on 2023/11/29.
//

import SwiftUI

struct ShapeDimensions {
    var height: CGFloat
    var width: CGFloat
}

struct CurrToDestIconView: View {
    var startShape: ShapeDimensions = ShapeDimensions(height: 6, width: 6)
    var endShape: ShapeDimensions = ShapeDimensions(height: 6, width: 6)
    
    var body: some View {
        
        VStack {
            Circle()
                .fill(Color(.systemGray3))
                .frame(width: startShape.width, height: startShape.height)
            Rectangle()
                .fill(Color(.systemGray3))
                .frame(width: 1, height: 24)
            Rectangle()
                .frame(width: endShape.width, height: endShape.height)
                
        }
    }
}

#Preview {
    CurrToDestIconView()
}
