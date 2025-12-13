//
//  CornerRadius.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import SwiftUI

struct RoundedCorner: Shape {

    var radius: CGFloat = 14
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

