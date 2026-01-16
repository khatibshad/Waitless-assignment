//
//  WATextView.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import SwiftUI

struct WATextView: View {
    let text: String
    var style: WATextStyle = .body
    var textColor: Color = .black

    var state: WATextState = .normal
    var multilineAlignment: TextAlignment = .leading

    private var config: WATextStyleConfig {
        style.config
    }

    var body: some View {
        Text(text)
            .font(config.font)
            .foregroundColor(textColor)
            .multilineTextAlignment(multilineAlignment)
    }
}

#Preview {
    WATextView(
        text: "This is body text",
    )
}

struct AppTextStyle: ViewModifier {
    let font: Font
    let color: Color
    let lineSpacing: CGFloat
    let alignment: TextAlignment

    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(color)
            .multilineTextAlignment(alignment)
            .lineSpacing(lineSpacing)
    }
}

extension WATextView {
    func appTextStyle(
        font: Font,
        color: Color = .primary,
        lineSpacing: CGFloat = 0,
        alignment: TextAlignment = .leading
    ) -> some View {
        modifier(
            AppTextStyle(
                font: font,
                color: color,
                lineSpacing: lineSpacing,
                alignment: alignment
            )
        )
    }
    
    func titleText() -> some View {
        appTextStyle(
            font: .system(size: 24, weight: .bold),
            color: .primary
        )
    }
    
    func bodyText() -> some View {
        appTextStyle(
            font: .system(size: 16),
            color: .secondary,
            lineSpacing: 4
        )
    }
    
    func captionText() -> some View {
        appTextStyle(
            font: .system(size: 12),
            color: .gray
        )
    }
}


struct WATextStyleConfig {
    let font: Font
    let normalColor: Color
    let selectedColor: Color?
    let disabledColor: Color?
}

enum WATextState {
    case normal
    case disabled
    case selected
}

enum WATextStyle {
    case title
    case body
    case caption
    case button
    case custom(style: WATextStyleConfig)
}


extension WATextStyle {

    var config: WATextStyleConfig {
        switch self {
        case .custom(let style):
            return style
        case .title:
            return .init(
                font: .custom("Shabnam-FD", size: 14),
                normalColor: .primary,
                selectedColor: .blue,
                disabledColor: .gray
            )

        case .body:
            return .init(
                font: .custom("Shabnam-FD", size: 14),
                normalColor: .secondary,
                selectedColor: nil,
                disabledColor: .gray.opacity(0.6)
            )

        case .caption:
            return .init(
                font: .custom("Shabnam-FD", size: 13),
                normalColor: .gray,
                selectedColor: nil,
                disabledColor: .gray.opacity(0.4)
            )

        case .button:
            return .init(
                font: .custom("Shabnam-FD", size: 14).weight(.bold),
                normalColor: .white,
                selectedColor: .white,
                disabledColor: .white.opacity(0.6)
            )
        }
    }
}
