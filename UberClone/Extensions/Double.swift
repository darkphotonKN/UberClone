//
//  Double.swift
//  UberClone
//
//  Created by Kranti on 2024/1/2.
//

import Foundation

// extending the default Double type to work with currencies
extension Double {
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        return formatter
    }
    
    // render the display currency
    func toCurrency() -> String {
        // converting the double to a visual string after formatted
        return currencyFormatter.string(for: self) ?? ""
    }
    
}
