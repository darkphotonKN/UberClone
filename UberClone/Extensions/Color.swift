//
//  Color.swift
//  UberClone
//
//  Created by Kranti on 2024/1/5.
//

import SwiftUI

extension Color {
    static let colorTheme = ColorTheme()
}

struct ColorTheme {
    var bgColor = Color("BackgroundColor")
    var reverseBgColor = Color("ReverseBackgroundColor")
    var reverseBgColorDark = Color("ReverseBackgroundColorDark")
    var secondaryBgColor = Color("SecondaryBackgroundColor")
    var textColor = Color("PrimaryTextColor")
    var reverseTextColor = Color("ReverseTextColor")
    var textColorError = Color("PrimaryTextError")
}
