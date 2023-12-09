//
//  LocationSearchDetailView.swift
//  UberClone
//
//  Created by Kranti on 2023/11/29.
//

import SwiftUI


// temp dummy Model
final class DummyLocation: Identifiable {
    var id = UUID()
    var title: String
    var address: String
    
    init(title: String, address: String) {
        self.title = title
        self.address = address
    }
}

struct LocationSearchDetailView: View {
    // pulling from the global instance of LocationSearchViewModel StateObject
    // NOT instantiating a new instance
    @EnvironmentObject var viewModel: LocationSearchViewModel

    // show detail view
    @Binding var showLocationSearchView: Bool
    
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
                                    // select location
                                    viewModel.selectLocation(selectedLocation: result.title)
                                    
                                    // dismiss detail view
                                    showLocationSearchView.toggle()
                                    
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
    LocationSearchDetailView(showLocationSearchView: .constant(false))
}
