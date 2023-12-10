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
    @Published var selectedLocation: CLLocationCoordinate2D?
    
    private let searchCompleter = MKLocalSearchCompleter()
    
    // to hold search values
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
    func selectLocation(selectedLocation: MKLocalSearchCompletion) {
        // using the MKLocalSearchCompletion string info of the map 
        // location selection to search for the actual coordinates of the location
        locationSearch(forLocalSearchCompletion: selectedLocation) { response, error in // using closure to tap into completion
            guard let locationSearchRes = response?.mapItems.first  else { return }
            let coordinate = locationSearchRes.placemark.coordinate
            
            self.selectedLocation = coordinate
        }
        
    }
    
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
}

// MKLocalSearchCompleterDelegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    // takes in the query fragment, does search in the background, and gives back the results
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results // update state array 
    }
    
}
