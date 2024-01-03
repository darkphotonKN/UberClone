//
//  HomeView.swift
//  UberClone
//
//  Created by Kranti on 2023/11/27.
//

import SwiftUI

struct HomeView: View {
    @State private var mapState: MapViewState = MapViewState.noInput
    @EnvironmentObject var viewModel: LocationSearchViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .bottom) {
                // MARK: Map
                UberMapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                // Ride Request Information
                // show Ride Request View after user chooses a location
                if(mapState == .locationSelected) {
                    RideRequestView()
                        .transition(.move(edge: .bottom)) // pairs with withAnimation to spring up from the bottom of the screen
                }
            }
                        
            
            // MARK: Map Search Input Overlay
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
            
            // MARK: Map Menu Button
            HStack {
                MapMenuButton(mapState: $mapState)
                    
                Spacer()
            }

        }
        .edgesIgnoringSafeArea(.bottom)
        // listen to the published state for changes
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location = location {
                print("DEBUG: user location in home view \(location)")
                // updates viewModel to follow the user location found in LocationManager
                viewModel.userLocation = location
            }
        }
    }
}

#Preview {
    HomeView()
}
