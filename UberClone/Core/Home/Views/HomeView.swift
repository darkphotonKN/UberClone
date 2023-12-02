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
                        
            
            // Map Overlay
            VStack {
                // Search Bar
                if(showLocationSearchView) {
                    LocationSearchDetailView()
                } else {
                    LocationSearchView()
                        .padding(.top, 77)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                showLocationSearchView.toggle()
                            }
                        }
                }
            }
            
            // Map Menu Button Area
            HStack {
                MapMenuButton(showLocationSearchView: $showLocationSearchView)
                    .padding(.leading, 25)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
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
