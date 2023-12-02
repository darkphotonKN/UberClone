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
    // tap into viewModel for the search results
    @StateObject var viewModel = LocationSearchViewModel()
    
    private var dummyData = [
        DummyLocation(title: "Starbucks Coffee", address: "32, Brookville Avenue, New York"),
        DummyLocation(title: "Starbucks Coffee", address: "32, Brookville Avenue, New York"),
        DummyLocation(title: "Starbucks Coffee", address: "32, Brookville Avenue, New York"),
        DummyLocation(title: "Starbucks Coffee", address: "32, Brookville Avenue, New York"),
        DummyLocation(title: "Starbucks Coffee", address: "32, Brookville Avenue, New York"),
        DummyLocation(title: "Starbucks Coffee", address: "32, Brookville Avenue, New York"),
        DummyLocation(title: "Starbucks Coffee", address: "32, Brookville Avenue, New York"),
        DummyLocation(title: "Starbucks Coffee", address: "32, Brookville Avenue, New York"),
        DummyLocation(title: "Dreamers Coffee", address: "12, Nashville St, Kensington, New York"),
        DummyLocation(title: "The Waterworks of Modern Men", address: "7, South Row Boulevard, New York"),
    ]
    
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
                        }
                    }
                }.onAppear() {
                    print("result: \(viewModel.results)")
                }
                
            }.background(.white)
        
    }
}

#Preview {
    LocationSearchDetailView()
}
