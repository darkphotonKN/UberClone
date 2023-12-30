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
            ZStack(alignment: .bottom) {
                // Map
                UberMapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                // Ride Request Information
                // show Ride Request View after user chooses a location
                if(mapState == .locationSelected) {
                    RideRequestView()
                        .transition(.move(edge: .bottom)) // pairs with withAnimation to spring up from the bottom of the screen
                }
            }
                        
            
            // Map Search Input Overlay
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
            
            // Map Menu Button
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

        }.edgesIgnoringSafeArea(.bottom)
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
