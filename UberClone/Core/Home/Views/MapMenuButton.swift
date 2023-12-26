//
//  File.swift
//  UberClone
//
//  Created by Kranti on 2023/11/29.
//

import SwiftUI

struct MapMenuButton: View {
    @Binding var mapState: MapViewState
    
    var body: some View {
        ZStack {
            // Background
            Circle()
                .foregroundStyle(.white)
                .shadow(color: .black, radius: 3)
                .frame(width: 55, height: 55)
            
            // Menu Button Lines
            Image(systemName: renderMapMenuIcon())
                .resizable()
                .frame(width: 20, height: 14)
                .foregroundColor(.black)
        }
    }
    
    // determine what type of map menu icon to render based on mapState
    func renderMapMenuIcon() -> String {
        switch(mapState) {
        case .searchingForLocation:
            return "arrow.left"
        case .noInput:
            return "line.3.horizontal"
        case .locationSelected:
            return "arrow.left"
        default:
            return "line.3.horizontal"
        }
    }
}

