//
//  RideType.swift
//  UberClone
//
//  Created by Kranti on 2024/1/1.
//

enum RideType: Int, CaseIterable, Identifiable {
    case uberX
    case uberXL
    case black
    
    var id: Int { return rawValue }
    
    var description: String {
        switch self {
        case .uberX:
            return "UberX"
        case .uberXL:
            return "UberXL"
        case .black:
            return "UberBlack"
        }
    }
    
    var imageName: String {
        switch self {
        case .uberX:
            return "uber-x"
        case .uberXL:
            return "uber-x"
        case .black:
            return "uber-black"
        }
    }
    
    var baseFare: Double {
        switch self {
        case.uberX:
            return 8
        case.uberXL:
            return 20
        case.black:
            return 25
        }
    }
    
    // calculates price based on distance of trip
    func calcTotalFare(distance distanceInMeters: Double) -> Double {
        let distanceInKm = distanceInMeters / 1000
        
        switch self {
        case.uberX:
            return distanceInKm*1.2 + baseFare
        case.uberXL:
            return distanceInKm*1.5 + baseFare
        case.black:
            return distanceInKm*2.3 + baseFare
        }
    }
    
}
