//
//  InputFieldView.swift
//  UberClone
//
//  Created by Kranti on 2024/1/6.
//

import SwiftUI

struct InputFieldView: View {
    @Binding var inpValue: String
    
    var label: String = "label"
    var placeholder: String = "placeholder"
    
    var body: some View {
        
        VStack(alignment: .leading) {

            VStack {
                Text(label)
                    .foregroundStyle(Color.colorTheme.textColor)
                    .fontWeight(.semibold)
                    .font(.system(size: 14))
            }
            
            TextField(placeholder, text: $inpValue)
                .foregroundStyle(Color.colorTheme.textColor)
            
            CustomDivider()
                .padding(.top, 8)
                .padding(.bottom, 14)
        }
    }
}

#Preview {
    LoginView()
}
