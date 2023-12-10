//
//  UberMapViewRepresentable.swift
//  UberClone
//
//  Created by Kranti on 2023/11/27.
//

import SwiftUI
import MapKit

/*
 Making mapkit from uikit useable in SwiftUI
 */

struct UberMapViewRepresentable: UIViewRepresentable {
    let mapView = MKMapView()
    
    // initialize location manager to request user's persmission to track their location
    // and to carry out the tracking
    let locationManger = LocationManager()
    
    // pulling from global instance of the locationViewModel, casting it and not re-intializing it
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    // in charge of creating the map view
    func makeUIView(context: Context) -> some UIView {
        // context object gives us access to the coordinator
        mapView.delegate = context.coordinator
        // configure map view settings
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
           
        return mapView
    }
    
    // for updating the map
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let selectedLocationCoord = locationViewModel.selectedLocation {
            print("DEBUG: Selected location in map view \(selectedLocationCoord)")
        }
    }
    
    // returns our custom class, creates the coordinator
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
    
}

extension UberMapViewRepresentable {
    // middle man between swiftui and uikit
    // we have access to the UberMapViewRepresentable but we're doing it from
    // this MapCoordinator
    // the "parent" is how we're going to communicate between
    // this MapCoordinate to the UberMapViewRepresentable
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: UberMapViewRepresentable
        
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            // locate user's location and zoom in on their span
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            
            // using the parent to update the mapView, again having MapCoordinator
            // be the one that talks to UberMapViewRepresentable, SwiftUI <-> UIKit
            parent.mapView.setRegion(region, animated: true)
        }
        
        
    }
    
}

