//
//  UberMapViewRepresentable.swift
//  UberClone
//
//  Created by Kranti on 2023/11/27.
//

import SwiftUI
import MapKit

/*
 The Primary Map View of this Application
 Making mapkit from uikit useable in SwiftUI
 */

struct UberMapViewRepresentable: UIViewRepresentable {
    let mapView = MKMapView()
    @Binding var mapState: MapViewState
    
    // initialize location manager to request user's persmission to track their location
    // and to carry out the tracking
    // let locationManger = LocationManager() // old code of using multiple instances
    let locationManager = LocationManager.shared
    
    
    // pulling from global instance of the locationViewModel, casting it and not re-intializing it
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    
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
        
        switch mapState {
            
        // every time the map view re-renders during no input we want to clear the map and re-center
        case .noInput:
            context.coordinator.clearMapViewAndCenter()
            break
            
            
        // location selected, we add and select the annotations and configure and draw polylines
        case .locationSelected:
            if let selectedLocationCoord = locationSearchViewModel.selectedLocation?.coordinate {
                print("DEBUG: Adding stuff to map!")
                // coordinator provides us with the function we created in the extension
                
                // use coordinator to get access to addAndSelectAnnotation and draw them user user-selected coords
                context.coordinator.addAndSelectAnnotation(withCoordinate: selectedLocationCoord)
                // use coordinator to get access to configurePolyline and draw the route with user-selected coords
                context.coordinator.configurePolyline(withDestinationCoordinate: selectedLocationCoord)
            }
            break
        
        // do nothing when user is inputing search location
        case .searchingForLocation:
            break
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
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?
        
        // MARK: - Properties
        let parent: UberMapViewRepresentable
        
        // MARK: - Lifecycle
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        // MARK: - MKMapViewDelegate
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            // set class-level user location
            self.userLocationCoordinate = userLocation.coordinate
                        
            // also update it for the LocationSearchViewModel
            self.parent.locationSearchViewModel
            
            // locate user's location and zoom in on their span
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            
            // update our currentRegion state which is used when clearing the map
            currentRegion = region
            
            // using the parent to update the mapView, again having MapCoordinator
            // be the one that talks to UberMapViewRepresentable, SwiftUI <-> UIKit
            parent.mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) ->
            MKOverlayRenderer {
                let polyline = MKPolylineRenderer(overlay: overlay)
                polyline.strokeColor = .systemBrown
                polyline.lineWidth = 6
                return polyline
            }
        
        
        // MARK: - Helpers
        
        // adding and selecting annotations
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            
            // remove old map annotations
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            // add new map annotation
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = coordinate
            
            parent.mapView.addAnnotation(annotation) // don't need self.parent because not in a block
            parent.mapView.selectAnnotation(annotation, animated: true)
            
            // zoom out to show all pins (with animation)
            // parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
            // ^ this job has been moved to configurePolyline with a more specific region
            // of the map
        }
        
        // draw map line between user location and target destination
        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            guard let userLocationCoordinate = self.userLocationCoordinate else { return }
            

            // get destination route and add overlay via new polyline
            self.parent.locationSearchViewModel.getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                
                // draw the polyline on the mapView by using an overlay and drawing with the polyline
                // from the route provided from the completion handler
                self.parent.mapView.addOverlay(route.polyline)
                
                print("DEBUG: current overlays AFTER: \(self.parent.mapView.overlays)")
                
                // create a smaller region of map to fit directly above our
                // search result view complete with polyline overlayed on top
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
        
        
        // clear map view annotations and overlays and recenters on user location
        func clearMapViewAndCenter() {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            
            if let currentRegion = currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
        
       
        
    }
    
}

#Preview {
    HomeView()
}
