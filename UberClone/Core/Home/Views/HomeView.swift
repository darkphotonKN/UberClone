//
//  HomeView.swift
//  UberClone
//
//  Created by Kranti on 2023/11/27.
//

import SwiftUI

struct HomeView: View {
    @State private var showLocationSearchView: Bool = false
 
    
    var body: some View {
        ZStack(alignment: .top) {
            // Map
            UberMapViewRepresentable()
                .ignoresSafeArea()
            // Map Menu Button Area
            HStack {
                MapMenuButton()
                    .padding(.top, 20)
                    .padding(.leading, 25)
                Spacer()
            }
            
            
            // Map Overlay
            VStack {
               
                // Search Bar
                if(showLocationSearchView) {
                    LocationSearchDetailView()
                } else {
                    LocationSearchView()
                        .padding(.top, 97)
                        .onTapGesture {
                            showLocationSearchView.toggle()
                        }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
