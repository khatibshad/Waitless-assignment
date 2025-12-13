//
//  WAButtonView.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import SwiftUI

enum WAButtonStyle {
    case background(bgColor: Color, textColor: Color)
    case border(bgColor: Color, textColor: Color, borderColor: Color)

    // Default style
    static let `default` = WAButtonStyle.background(
        bgColor: .blue,
        textColor: .white
    )
}

struct WAButtonView: View {

    let title: String
    let action: () -> Void

    var style: WAButtonStyle = .default
    var isEnabled: Bool = true
    var isLoading: Bool = false
    var image: Image? = nil

    private var isButtonEnabled: Bool {
        isEnabled && !isLoading
    }

    var body: some View {
        Button(action: {
            if !isLoading {
                action()
            }
        }) {
            ZStack {
                // Keeps size stable
                HStack(spacing: 8) {
                    if let image { image }

                    Text(title)
                        .font(.custom("Shabnam-FD", size: 14))
                }
                .fontWeight(.bold)
                .opacity(isLoading ? 0 : 1)

                // Loading indicator
                if isLoading {
                    ProgressView()
                        .progressViewStyle(
                            CircularProgressViewStyle(tint: style.textColor)
                        )
                }
            }
            .foregroundColor(style.textColor)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .background(style.backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        style.borderColor,
                        lineWidth: style.hasBorder ? 1 : 0
                    )
            )
            .cornerRadius(12)
            .opacity(isButtonEnabled ? 1 : 0.5)
            .animation(.easeInOut(duration: 0.2), value: isLoading)
        }
        .disabled(!isButtonEnabled)
    }
}


extension WAButtonStyle {

    var backgroundColor: Color {
        switch self {
        case .background(let bgColor, _):
            return bgColor
        case .border(let bgColor, _, _):
            return bgColor
        }
    }

    var textColor: Color {
        switch self {
        case .background(_, let textColor):
            return textColor
        case .border(_, let textColor, _):
            return textColor
        }
    }

    var borderColor: Color {
        switch self {
        case .background:
            return .clear
        case .border(_, _, let borderColor):
            return borderColor
        }
    }

    var hasBorder: Bool {
        if case .border = self { return true }
        return false
    }
}



#Preview {
    VStack(spacing: 16) {
        WAButtonView(
            title: "Primary",
            action: {}, style: .default, isLoading: true
        )

        WAButtonView(
            title: "Border",
            action: {}, style: .border(bgColor: .white, textColor: .blue, borderColor: .blue), image: Image(systemName: "heart.fill")
        )

        WAButtonView(
            title: "Disabled",
            action: {}, style: .background(bgColor: .red, textColor: .white), isEnabled: false
        )
    }
    .padding()
}
