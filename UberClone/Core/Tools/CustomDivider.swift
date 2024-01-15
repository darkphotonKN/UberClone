//
//  Divider.swift
//  UberClone
//
//  Created by Kranti on 2024/1/7.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        Rectangle()
            .foregroundStyle(Color(.init(white: 1, alpha: 0.3)))
            .frame(width: UIScreen.main.bounds.width - 30, height: 0.7)
    }
}

#Preview {
    CustomDivider()
}
