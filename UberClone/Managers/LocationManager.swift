//
//  LocationManager.swift
//  UberClone
//
//  Created by Kranti on 2023/11/27.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
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
 location-related events to your app. Implement this protocol
 in an app-specific object and use the methods to update your app.
 */
extension LocationManager: CLLocationManagerDelegate {
    // function that is called when user location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else { return }
        // stops location update when we've recieved their inital location,
        // where we can then let our map take over
        locationManager.stopUpdatingLocation()
    }
}
