//
//  WATextField.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import SwiftUI
import UIKit

struct WATextField: View {
    
    struct TxtAction {
        let image: Image
        let action: () -> Void
    }

    // MARK: - Public API
    let placeholder: String
    @Binding var text: String

    var isSecure: Bool = false
    var isDisabled: Bool = false
    var cornerRadius: CGFloat = 12
    var rules: [WAValidationRule] = []
    var trailingView: (() -> AnyView)? = nil
    var maxLength: Int? = nil
    var rightView: TxtAction?

    // MARK: - State
    @State private var state: WATextFieldState = .normal
    @State private var isSecureText: Bool = false
    @FocusState private var isFocused: Bool

    // MARK: - Init
    init(
        placeholder: String,
        text: Binding<String>,
        isSecure: Bool = false,
        isDisabled: Bool = false,
        cornerRadius: CGFloat = 12,
        rules: [WAValidationRule] = [],
        maxLength: Int? = nil,
        trailingView: (() -> AnyView)? = nil,
        rightView: TxtAction? = nil
    ) {
        self.placeholder = placeholder
        self._text = text
        self.isSecure = isSecure
        self.isDisabled = isDisabled
        self.cornerRadius = cornerRadius
        self.rules = rules
        self.maxLength = maxLength
        self.trailingView = trailingView
        self.rightView = rightView
        self._isSecureText = State(initialValue: isSecure)
    }

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {

            field

            if case let .error(message) = state {
                Text(message)
                    .font(.custom("Shabnam-FD", size: 12))
                    .foregroundColor(.main)
            }
        }
        .onChange(of: text) { newValue in
            guard let maxLength else { return }

            if newValue.count > maxLength {
                text = String(newValue.prefix(maxLength))
            }
        }
        .onChange(of: isFocused) { focused in
            if !focused {
                validate()
            } else {
                state = .focused
            }
        }
        .disabled(isDisabled)
        .animation(.easeInOut(duration: 0.2), value: state)
    }
}

private extension WATextField {

    var field: some View {
        HStack(spacing: 8) {

            ZStack(alignment: .leading) {

                if text == "" {
                    Text(placeholder)
                        .foregroundColor(.black.opacity(0.6))
                        .padding(.horizontal, 12)
                        .opacity(text.isEmpty ? 1 : 0)
                        .allowsHitTesting(false)
                }

                if isSecureText {
                    SecureField("", text: $text)
                } else {
                    TextField("", text: $text)
                }
            }

            if isSecure {
                Button {
                    isSecureText.toggle()
                } label: {
                    Image(systemName: isSecureText ? "eye.slash" : "eye")
                        .foregroundColor(.black)
                }
            } else if let trailingView {
                trailingView()
            } else if let rightView = self.rightView {
                Button {
                    rightView.action()
                } label: {
                    rightView.image
                        .foregroundColor(.black)
                }
            }
        }
        .font(.custom("Shabnam-FD", size: 14))
        .padding(.horizontal, 12)
        .frame(height: 48)
        .background(backgroundColor)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor, lineWidth: 1)
        )
        .cornerRadius(cornerRadius)
        .focused($isFocused)
    }
}


private extension WATextField {

    var borderColor: Color {
        switch state {
        case .focused:
            return .blue
        case .success:
            return .green
        case .error:
            return .main
        case .disabled:
            return .clear
        default:
            return .black.opacity(0.4)
        }
    }

    var backgroundColor: Color {
        isDisabled ? .gray.opacity(0.1) : .white
    }
}

private extension WATextField {

    func validate() {
        guard !isDisabled else {
            state = .disabled
            return
        }

        for rule in rules where !rule.validate(text) {
            state = .error(rule.errorMessage)
            return
        }

        state = text.isEmpty ? .normal : .success
    }
}

enum WATextFieldState: Equatable {
    case normal
    case focused
    case success
    case error(String)
    case disabled
}

struct WAValidationRule {
    let errorMessage: String
    let validate: (String) -> Bool
}

extension WAValidationRule {

    static let required = WAValidationRule(
        errorMessage: "This field is required"
    ) { !$0.trimmingCharacters(in: .whitespaces).isEmpty }

    static let email = WAValidationRule(
        errorMessage: "Invalid email address"
    ) {
        $0.contains("@") && $0.contains(".")
    }

    static func minLength(_ length: Int) -> WAValidationRule {
        .init(errorMessage: "Minimum \(length) characters") {
            $0.count >= length
        }
    }
}


#Preview {
    VStack(spacing: 24) {

        // Normal
        WATextField(
            placeholder: "Username",
            text: .constant("")
        )

        // Focused (simulate with prefilled text)
        WATextField(
            placeholder: "Full Name",
            text: .constant("John Appleseed")
        )

        // Email with validation error
        WATextField(
            placeholder: "Email",
            text: .constant("invalid-email"),
            rules: [
                .required,
                .email
            ]
        )

        // Success state
        WATextField(
            placeholder: "Phone",
            text: .constant("09123456789"),
            rules: [
                .minLength(10)
            ]
        )

        // Secure / Password
        WATextField(
            placeholder: "Password",
            text: .constant("123456"),
            isSecure: true,
            rules: [
                .minLength(8)
            ]
        )

        // Disabled
        WATextField(
            placeholder: "Disabled Field",
            text: .constant("Can't edit"),
            isDisabled: true
        )
    }
    .padding()
}

struct WAKeyboardToolbar: View {

    let onNext: (() -> Void)?
    let onDone: () -> Void

    var body: some View {
        HStack {
            if let onNext {
                Button("Next", action: onNext)
            }

            Spacer()

            Button("Done", action: onDone)
        }
        .padding()
        .background(Color(.systemGray6))
    }
}
