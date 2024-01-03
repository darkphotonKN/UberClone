//
//  LocationManager.swift
//  UberClone
//
//  Created by Kranti on 2023/11/27.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    // singleton shared instance of LocationManager for the entire application
    static var shared = LocationManager()
    
    // store userLocation
    @Published var userLocation: CLLocationCoordinate2D?
    
    // initalize the request for user's permission for INITIAL map view location
    override init() {
        super.init();
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // use best accuracy possible
        locationManager.requestWhenInUseAuthorization() // request user permission to use their location when app is being used
        locationManager.startUpdatingLocation() // starts tracking user location
    }
}

/*
 The location manager calls its delegate’s methods to report 
 location-related events to the app.
 
 Implement this protocol in an app-specific object and we use the methods to update the app.
 */
extension LocationManager: CLLocationManagerDelegate {
    // function that is called when user location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        print("DEBUG: updating user location @LocationManger with: \(location)")
        
        // update our published state userLocation with the unwrapped location's coordinate
        userLocation = location.coordinate
        
        // stops location update when we've recieved their inital location,
        // where we can then let our map take over
        locationManager.stopUpdatingLocation()
    }
}
