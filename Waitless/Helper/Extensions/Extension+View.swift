//
//  Extension+View.swift
//  Waitless
//
//  Created by shayan khatibshad on 2026-01-16.
//

import SwiftUI

extension View {
    func toast(isPresented: Binding<Bool>, message: String, duration: TimeInterval = 2.0) -> some View {
        self.modifier(ToastModifier(isPresented: isPresented, message: message, duration: duration, toastMode: .error))
    }
    
    func toast(error: Binding<ErrorState?>, duration: TimeInterval = 2.0) -> some View {
        self.modifier(ErrorToastModifier(error: error, duration: duration, toastMode: .error))
    }
    func toast(error: Binding<ErrorState?>, mode: ToasMode, duration: TimeInterval = 2.0) -> some View {
        self.modifier(ErrorToastModifier(error: error, duration: duration, toastMode: mode))
    }
    func hideKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil,
                from: nil,
                for: nil
            )
        }
    }
    func keyboardDoneToolbarTxt() -> some View {
        toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button(action: {
                    UIApplication.shared.sendAction(
                        #selector(UIResponder.resignFirstResponder),
                        to: nil,
                        from: nil,
                        for: nil
                    )
                }) {
                    Text("Done")
                        .foregroundColor(Color.blue)
                }
            }
        }
    }
    func keyboardDoneToolbarImage() -> some View {
        toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button {
                    UIApplication.shared.sendAction(
                        #selector(UIResponder.resignFirstResponder),
                        to: nil,
                        from: nil,
                        for: nil
                    )
                } label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                }
            }
        }
    }
}
