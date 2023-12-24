//
//  HomeView.swift
//  UberClone
//
//  Created by Kranti on 2023/11/27.
//

import SwiftUI

struct HomeView: View {
    @State private var mapState: MapViewState = MapViewState.noInput
    
    var body: some View {
        ZStack(alignment: .top) {
            // Map View
            UberMapViewRepresentable(mapState: $mapState)
                .ignoresSafeArea()
                        
            
            // Map Overlay
            VStack {
                // in non-search mode
                if(mapState == .noInput) {
                    // show main search bar and map
                    LocationSearchView()
                        .padding(.top, 77)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                // toggle back to main view
                                mapState = .searchingForLocation
                                // and show selected location details
                            }
                        }
                } else if(mapState == .searchingForLocation) {
                    // detail search
                    LocationSearchDetailView(mapState: $mapState)
                }
            }
            
            // Map Menu Button Area
            HStack {
                MapMenuButton(mapState: $mapState)
                    .padding(.leading, 25)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            actionForState(state: mapState)
                        }
                    }
                Spacer()
            }

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
            mapState = .noInput
        }
    }
}

#Preview {
    HomeView()
}
