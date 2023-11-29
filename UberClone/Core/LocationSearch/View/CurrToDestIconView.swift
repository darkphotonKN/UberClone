//
//  CurrToDestIconView.swift
//  UberClone
//
//  Created by Kranti on 2023/11/29.
//

import SwiftUI

struct CurrToDestIconView: View {
    var body: some View {
        
        VStack {
            Circle()
                .fill(Color(.systemGray3))
                .frame(width: 6, height: 6)
            Rectangle()
                .fill(Color(.systemGray3))
                .frame(width: 1, height: 24)
            Rectangle()
                .frame(width: 6, height: 6)
                
        }
    }
}

#Preview {
    CurrToDestIconView()
}
