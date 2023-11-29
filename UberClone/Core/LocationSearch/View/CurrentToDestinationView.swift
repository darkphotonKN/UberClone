//
//  CurrentToDestinationView.swift
//  UberClone
//
//  Created by Kranti on 2023/11/29.
//

import SwiftUI

struct CurrentToDestinationView: View {
    @State private var currentLocation = ""
    @State private var destinationLocation = ""
    
    var body: some View {
        VStack {
            TextField("Current Location", text: $currentLocation)
                .frame(height: 32)
                .background(Color(.systemGroupedBackground))
                
            TextField("Where to?", text: $destinationLocation)
                .frame(height: 32)
                .background(Color(.systemGray4))
                
        }
    }
}

#Preview {
    CurrentToDestinationView()
}
