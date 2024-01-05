//
//  LoginView.swift
//  UberClone
//
//  Created by Kranti on 2024/1/6.
//

import SwiftUI

struct LoginView: View {
    @State private var emailField: String = ""
    @State private var passwordField: String = ""
    
    var body: some View {
        ZStack {
            Color(.black).ignoresSafeArea()
            
            VStack {
                // Logo and Title
                VStack {
                    // image
                    Image("uber-app-icon")
                        .resizable()
                        .frame(width: 160, height: 160)
                        .foregroundStyle(.white)
                    
                    // title
                    Text("UBER")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .padding(.top)
                }
                
                // Core Content Area
                VStack {
                    // MARK: Input Fields
                    
                    // email
                    InputFieldView(inpValue: $emailField, label: "Email Address", placeholder: "name@example.com")
                    // password
                    InputFieldView(inpValue: $passwordField, label: "Password", placeholder: "Enter your password")
                    HStack {
                        Text("Test")
                            .foregroundStyle(.white)
                        Spacer()
                    }
                }.padding([.leading, .trailing], 16)
                
            }
        }
    }
}

#Preview {
    LoginView()
}
