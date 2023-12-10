//
//  UberCloneApp.swift
//  UberClone
//
//  Created by Kranti on 2023/11/27.
//

import SwiftUI

@main
struct UberCloneApp: App {
    // singular instance of locationViewModel
    // used to update the location information selected by the user,
    // which after selected propogates the changes through the app
    @StateObject var locationViewModel = LocationSearchViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(locationViewModel)
        }
    }
}
