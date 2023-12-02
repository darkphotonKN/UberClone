//
//  File.swift
//  UberClone
//
//  Created by Kranti on 2023/11/29.
//

import SwiftUI

struct MapMenuButton: View {
    @Binding var showLocationSearchView: Bool
    
    var body: some View {
        ZStack {
            // Background
            Circle()
                .foregroundStyle(.white)
                .shadow(color: .black, radius: 3)
                .frame(width: 55, height: 55)
            
            // Menu Button Lines
            Image(systemName: showLocationSearchView ? "arrow.left" : "line.3.horizontal")
                .resizable()
                .frame(width: 20, height: 14)
                .foregroundColor(.black)
        }
    }
}

