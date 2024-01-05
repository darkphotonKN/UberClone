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
        
        VStack {
            HStack {
                Text(label)
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                    .font(.system(size: 18))
                Spacer()
                
                TextField(text: $inpValue, label: { Text(placeholder)})
            }
        }
    }
}

#Preview {
    LoginView()
}
