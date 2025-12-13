//
//  WAColor.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import Foundation
import SwiftUI

enum WAColor {

    // MARK: - Brand
    static let primary = Color("Primary")
    static let secondary = Color("Secondary")
    static let accent = Color("Accent")

    // MARK: - Text
    static let textPrimary = Color("TextPrimary")
    static let textSecondary = Color("TextSecondary")
    static let textDisabled = Color("TextDisabled")

    // MARK: - Background
    static let background = Color("Background")
    static let surface = Color("Surface")

    // MARK: - Border
    static let border = Color("Border")
    static let divider = Color("Divider")

    // MARK: - State
    static let success = Color("Success")
    static let error = Color("Error")
    static let warning = Color("Warning")
    static let disabled = Color("Disabled")
}

extension Color {

    init(hex: String, opacity: Double = 1.0) {
        let hex = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex)

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(.sRGB, red: r, green: g, blue: b, opacity: opacity)
    }
}
