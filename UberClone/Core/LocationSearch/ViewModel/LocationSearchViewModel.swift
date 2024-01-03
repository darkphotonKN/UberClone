//
//  LocationSearchViewModel.swift
//  UberClone
//
//  Created by Kranti on 2023/12/3.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    
    // Properties
    
    // helps with autocomplete when entering search term
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedLocation: UberLocation? {
        didSet {
            print("DEBUG: updated selectedLocation was - \(selectedLocation)")
        }
    }
    @Published var rideTimes: RideTimes?
    
    // store user location
    var userLocation: CLLocationCoordinate2D? {
        didSet {
            print("DEBUG: updated userLocation was - \(userLocation)")
        }
    }
    
    
    private let searchCompleter = MKLocalSearchCompleter()
    
    // store search values
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
        
    // Lifecycle
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    // Helpers
    
    // sets selectedLocation with the location coordinate based on the MKLocalSearchCompletion selected
    func selectLocation(selectedLocation: MKLocalSearchCompletion) {
        // using the MKLocalSearchCompletion string info of the map 
        // location selection to search for the actual coordinates of the location
        locationSearch(forLocalSearchCompletion: selectedLocation) { response, error in
            
            // check for error case
            if let error = error {
                print("DEBUG: error occured - \(error)")
                return
            }
            guard let locationSearchRes = response?.mapItems.first  else { return }
            let coordinate = locationSearchRes.placemark.coordinate
            
            // create UberLocation object
            let uberLocation = UberLocation(title: selectedLocation.title, coordinate: coordinate)
            
            self.selectedLocation = uberLocation
        }
        
    }
    
    // searches for the location infromation by using naturalLanguageQuery 
    // and making the search with MKLocalSearch
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        
        // create request string
        let searchRequest = MKLocalSearch.Request()
        
        // search with both the title of the location (name of location) and the subtitle (address of location)
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        
        // make search request
        let search = MKLocalSearch(request: searchRequest)
        // completion is a callback (completion handler) which takes time
        search.start(completionHandler: completion)
    }
    
    // calculate price based on distance from user's location to selected location
    func calcRidePrice(rideType: RideType) -> Double {
        // unwrap both user and selected locations
        guard let selectedLocation = selectedLocation?.coordinate else { return 0.0 }
        guard let userLocation = userLocation else { return 0.0 }
        
        // create the CLLocation objects
        let userCLLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let selectedCLLocation = CLLocation(latitude: selectedLocation.latitude, longitude: selectedLocation.longitude)
        
        // compute distance between the two locations
        let distance = userCLLocation.distance(from: selectedCLLocation) // in meters
        
        // find and return the corresponding price
        let finalPrice = rideType.calcTotalFare(distance: distance)
        
        return finalPrice
    }
    
    // gets destination route by using user's location coords and destination coords 
    func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void) {
    
        // create placemarks
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        
        // use placemarks to draw line
        
        let request = MKDirections.Request()
        // draw start
        request.source = MKMapItem(placemark: userPlacemark)
        // draw end
        request.destination = MKMapItem(placemark: destinationPlacemark)
        
        let directions = MKDirections(request: request)
        
        // this is a request API which means it must be handled by a completion handler (callback)
        directions.calculate { response, error in
            if let error = error {
                print("DEBUG: Failed to get direction with error")
            }
            
            guard let route = response?.routes.first else { return }
            
            // calculate destination time
            self.analyzePickupAndDropoffTime(expectedTravelTime: route.expectedTravelTime) // provided from directions from MKDirections
            
            completion(route)
        }
    }
    
    // sets the time for destination
    func analyzePickupAndDropoffTime(expectedTravelTime: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        let pickupTime = formatter.string(from: Date()) // converts the date-time now to our required format
        let dropoffTime = formatter.string(from: Date().addingTimeInterval(expectedTravelTime))

        print("pickupTime: \(pickupTime), \n dropoffTime: \(dropoffTime)")
        let rideTimes = RideTimes(pickupTime: pickupTime, dropoffTime: dropoffTime)
        self.rideTimes = rideTimes
    }
    
}

// MKLocalSearchCompleterDelegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    // takes in the query fragment, does search in the background, and gives back the results
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results // update state array 
    }
    
}
