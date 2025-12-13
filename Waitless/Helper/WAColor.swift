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
    static let textPrimary = Color.black
    static let textSecondary = Color(hex: "#5A5050")
    static let textDisabled = Color.gray

    // MARK: - Background
    static let background = Color.white
    static let surface = Color("Surface")

    // MARK: - Border
    static let border = Color.gray
    static let divider = Color.gray

    // MARK: - State
    static let success = Color.green
    static let error = Color.red
    static let warning = Color.yellow
    static let disabled = Color.red
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
