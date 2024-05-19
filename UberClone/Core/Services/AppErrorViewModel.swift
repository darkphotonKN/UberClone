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
        print("@setError setting error with: \(error), specifically \(error.localizedDescription)")
        self.apiErrorMessage = error.localizedDescription
        
        print("DEBUG @AppErrorViewModel apiErrorMessage: \(self.apiErrorMessage)")
    }
    
    func clearError() {
        self.apiErrorMessage = nil
    }
    
}
