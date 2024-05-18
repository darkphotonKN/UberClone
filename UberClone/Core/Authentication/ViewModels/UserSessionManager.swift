//
//  AuthViewModel.swift
//  UberClone
//
//  Created by Kranti on 2024/5/6.
//



import SwiftUI
import Foundation
import KeychainAccess

/**
 Sets up an instance of an auth session after logging in.
 
 Flow:
 
 instantiate a view model and use environmentobject to pass it to any page that needs it
 
 login method is provided by this view model
 */


struct LoginInfo: Codable {
    var email: String
    var password: String
}

struct LoginApiResponse: Decodable {
    let status: Int
    let message: String
    let user: User
}

class UserSessionManager: ObservableObject {
    var appErrors: AppErrorViewModel?
    
    @Published var user: User?
    @Published var isAuthenticated: Bool = false
    // setup keychain
    private let keychain = Keychain(service: "com.krantiapps.uberclone")
    // setup singleton instance
    private let networkManager = NetworkManager.shared
    

    func login(email: String, password: String) {
        
        print("appErrors:", appErrors?.apiErrorMessage)
        
        NetworkManager.shared.postRequest(url: "/auth/login", payload: LoginInfo(email: email, password: password)) { (result: Result<LoginApiResponse, Error>) in
            
            DispatchQueue.main.async {
                switch result {
                    
                    // login succeeded, user info and token recieved
                case .success(let response):
                    print("DEBUG success response: \(response)")
                    
                    // set global user state to the user object from response
                    self.user = response.user
                    
                    // set global isAuthenticated state to true
                    self.isAuthenticated = true
                    
                    // store user information in keychain
                    do {
                        try self.keychain.set(response.user.token, key: "authToken")
                        
                        print("DEBUG success response: \(response)")
                    } catch {
                        print("DEBUG error response: \(error)")
                        
                        // set global error
                        self.appErrors?.setError(error: error)
                    }
                    
                    // login failed
                case .failure(let error):
                    self.isAuthenticated = false
                    print("DEBUG error after POST request: \(error)")
                    
                    // set global error
                    self.appErrors?.setError(error: error)
                    
                }
            }
        }
    }
}
