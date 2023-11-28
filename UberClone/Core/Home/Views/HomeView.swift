//
//  HomeView.swift
//  UberClone
//
//  Created by Kranti on 2023/11/27.
//

import SwiftUI

struct HomeView: View {
 
    
    var body: some View {
        UberMapViewRepresentable()
            .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
