//
//  LocationSearchViewModel.swift
//  UberClone
//
//  Created by Kranti on 2023/12/3.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    // helps with autocomplete when entering search term
    @Published var results = [MKLocalSearchCompletion]()
    private let searchCompleter = MKLocalSearchCompleter()
    // to hold search values
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    // takes in the query fragment, does search in the background, and gives back the results
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results // update state array 
    }
    
}
