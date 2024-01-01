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
    
}
