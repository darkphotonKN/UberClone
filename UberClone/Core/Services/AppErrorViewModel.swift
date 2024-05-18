//
//  AppErrorViewModel.swift
//  UberClone
//
//  Created by Kranti on 2024/5/18.
//

import SwiftUI

class AppErrorViewModel: ObservableObject {
    @Published var apiErrorMessage: String?
    
    func setError(error: Error) {
        self.apiErrorMessage = error.localizedDescription
    }
    
    func clearError() {
        self.apiErrorMessage = nil
    }
    
}
