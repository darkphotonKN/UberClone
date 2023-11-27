//
//  LocationManager.swift
//  UberClone
//
//  Created by Kranti on 2023/11/27.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init();
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // use best accuracy possible
        locationManager.requestWhenInUseAuthorization() // request user permission to use their location when app is being used
        locationManager.startUpdatingLocation() // starts tracking user location
        
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else { return }
        locationManager.stopUpdatingLocation() // stops location update
    }
}
