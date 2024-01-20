//
//  RegistrationView.swift
//  UberClone
//
//  Created by Kranti on 2024/1/6.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    private let topBotOffset: CGFloat = 44
    
    // for dismissing the navigation direction to this view
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        ZStack {
            Color(Color.colorTheme.bgColor).ignoresSafeArea()
            HStack {
                VStack(alignment: .leading) {
                    // MARK: Return to Login
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(Color.colorTheme.textColor)
                            .font(.system(size: 22))
                            
                    }
                    .padding(.top, topBotOffset)
                
                    // MARK: Title
                    Text("Create new")
                        .font(.system(size: 36, weight: .semibold))
                        .foregroundStyle(Color.colorTheme.textColor)
                        .padding(.top, 30)
                    Text("account")
                        .font(.system(size: 36, weight: .semibold))
                        .foregroundStyle(Color.colorTheme.textColor)
                
                    // MARK: Signup Form Inputs
                    
                    // name
                    InputFieldView(inpValue: $name, label: "Full Name", placeholder: "Enter your name")
                        .padding(.top, 25)
                
                    // email
                    InputFieldView(inpValue: $email, label: "Email Address", placeholder: "name@example.com")
                        .padding(.top, 25)
                    
                    // password
                    InputFieldView(inpValue: $password, label: "Create Password", placeholder: "Enter your password")
                        .padding(.top, 25)
                    
                    // MARK: Sign up Button
                    Spacer()
                    
                    Button {
                        print("Signing in...")
                    } label: {
                        Text("Sign Up")
                            .padding(.trailing, 10)
                            .foregroundStyle(Color.colorTheme.reverseTextColor)
                            .font(.system(size: 20, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                    }
                    .background(Color.colorTheme.reverseBgColorDark)
                    .cornerRadius(14)
                    .padding(.bottom, topBotOffset)
                    
                    
                }
                .padding(.horizontal, 16)
                .padding(.top, 5)
                .padding(.bottom, 13)
                Spacer()
            }
        }
    }
}

#Preview {
    RegistrationView()
}
