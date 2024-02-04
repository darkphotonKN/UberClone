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
        NavigationStack {
            ZStack {
                Color(Color.colorTheme.bgColor).ignoresSafeArea()
                
                VStack {
                    Spacer()
                    // MARK:  Logo and Title
                    VStack {
                        // logo
                        Image("uber-app-icon")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .background(Color(.white))
                            .cornerRadius(33)
                        
                        // title
                        Text("UBER")
                            .foregroundStyle(Color.colorTheme.textColor)
                            .font(.largeTitle)
                            .padding(.top, 10)
                    }
                    
                    
                    // Core Content Area
                    VStack {
                        // MARK: Input Fields
                        
                        // email
                        InputFieldView(inpValue: $emailField, label: "Email Address", placeholder: "name@example.com")
                        // password
                        InputFieldView(inpValue: $passwordField, label: "Password", placeholder: "Enter your password")
                        
                        
                        // MARK: Forgot Password
                        HStack {
                            Spacer()
                            Button {
                                
                            } label: {
                                
                                Text("Forgot Password?")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.white)
                                   
                            }
                        }
                        
                        // MARK: Social Area
                        
                        // social separator
                        HStack {
                            Rectangle()
                                .frame(width: 80, height: 1)
                                .foregroundStyle(Color.colorTheme.reverseBgColor)
                            
                            Text("Sign in with social")
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.colorTheme.textColor)
                                .padding([.leading, .trailing], 10)
                                .frame(minWidth: 164)
                            
                            Rectangle()
                                .frame(width: 80, height: 1)
                                .foregroundStyle(Color.colorTheme.reverseBgColor)
                            
                        }.padding(.top, 30)
                        
                        // social login buttons
                        HStack {
                            Image("facebook-login-icon")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .padding(.trailing, 14)
                            Image("google-login-icon")
                                .resizable()
                                .frame(width: 33, height: 33)
                        }.padding(.top, 10)
                        
                        // MARK: Sign In Area
                        
                        Button {
                            
                        } label: {
                            HStack {
                                Text("SIGN IN")
                                    .padding(.trailing, 10)
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                            }
                            .foregroundStyle(Color.colorTheme.reverseTextColor)
                            .font(.system(size: 20, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                        }
                        .background(Color.colorTheme.reverseBgColorDark)
                        .cornerRadius(14)
                        .padding(.top, 20)

                        HStack {
                            Text("Don't have an account?")
                                .foregroundStyle(Color.colorTheme.reverseBgColor)
                                .font(.system(size: 16))
                           
                            NavigationLink {
                                RegistrationView()
                                    // hides the default back button on the top bar
                                    .navigationBarBackButtonHidden(true)
                                
                            } label: {
                                Text("Sign Up")
                                    .foregroundStyle(Color.colorTheme.reverseBgColor)
                                    .font(.system(size: 17))
                            }
                            
                        }
                        .padding(.top, 20)
                        
                        
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 5)
                    .padding(.bottom, 13)
                    
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
