//
//  File.swift
//  UberClone
//
//  Created by Kranti on 2023/11/29.
//

import SwiftUI

struct MapMenuButton: View {
    @Binding var mapState: MapViewState
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    
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
        }.padding(.leading, 25)
            .onTapGesture {
                withAnimation(.easeInOut) {
                    actionForState(state: mapState)
                }
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
    
    // determining how the MapMenuButton should mutate view
    // state based on current map view state
    func actionForState(state: MapViewState) {
        switch state {
        case .searchingForLocation:
            mapState = .noInput
            break
        case .noInput:
            mapState = .noInput
            break
        case .locationSelected:
            // return to noInput state
            mapState = .noInput
            // clear previously selected location
            locationSearchViewModel.selectedLocation = nil
        }
    }
}

