//
//  LocationSearchDetailView.swift
//  UberClone
//
//  Created by Kranti on 2023/11/29.
//

import SwiftUI

struct LocationSearchDetailView: View {
    // pulling from the global instance of LocationSearchViewModel StateObject
    // NOT instantiating a new instance
    @EnvironmentObject var viewModel: LocationSearchViewModel

    // show detail view
    @Binding var mapState: MapViewState
    
    var body: some View {
       
            VStack {
                // Current Location & Destination Location Area
                HStack {
                    // Deco Icon
                    CurrToDestIconView()
                        .padding(.trailing, 12)
                    // Search Inputs
                    CurrentToDestinationView(queryFragment: $viewModel.queryFragment)
                }
                .padding([.leading, .trailing], 20)
                .padding(.top, 77)
                
                Divider().padding(.vertical, 23)
                
                // Search Result Location List
                ScrollView {
                    VStack {
                        // list out all the search result locations
                        ForEach(viewModel.results, id: \.self) { result in
                            
                            LocationSearchResultView(title: result.title, description: result.subtitle)
                                .onTapGesture {
                                    // with spring animation for Request Ride View popping up
                                    withAnimation(.spring()) {
                                        // select location
                                        viewModel.selectLocation(selectedLocation: result)
                                        
                                        // dismiss detail view
                                        mapState = .locationSelected
                                    }
                                    
                                }
                        }
                    }
                }.onAppear() {
                    print("result: \(viewModel.results)")
                }
                
            }.background(.white)
        
    }
}

#Preview {
    LocationSearchDetailView(mapState: .constant(MapViewState.searchingForLocation))
}
