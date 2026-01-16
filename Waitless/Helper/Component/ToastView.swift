//
//  ToastView.swift
//  Waitless
//
//  Created by shayan khatibshad on 2026-01-16.
//

import SwiftUI

enum ToasMode {
    case warning
    case error
    case success
    
    var image: Image {
        switch self {
        case .warning:
            Image("ic-toast-warning")
        case .error:
            Image("ic-toast-error")
        case .success:
            Image("ic-toast-success")
        }
    }
    
    var bgcolor: String {
        switch self {
        case .warning:
            return "#FFE099"
        case .error:
            return "#FFDADA"
        case .success:
            return "#C7F4C2"
        }
    }
}

struct ErrorState: Identifiable, Equatable, Error {
    let id = UUID()
    let message: String

    static func == (lhs: ErrorState, rhs: ErrorState) -> Bool {
        lhs.id == rhs.id && lhs.message == rhs.message
    }
}
struct ToastView: View {
    var message: String
    let mode: ToasMode

    var body: some View {
        HStack {
            Spacer()
            Text(message)
                .font(.custom("Shabnam-FD", size: 14))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
            mode.image
        }
        .padding()
        .background(Color.init(hex: mode.bgcolor))
        .cornerRadius(12)
        .shadow(radius: 10)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .onAppear {
            let generator = UINotificationFeedbackGenerator()
            switch mode {
            case .success:
                generator.notificationOccurred(.success)
            case .error:
                generator.notificationOccurred(.error)
            default:
                generator.notificationOccurred(.warning)
            }
        }
    }
}

#Preview {
    ToastView(message: "Toast View", mode: .error)
}

enum ToastPosition {
    case top
    case bottom
}

struct ErrorToastModifier: ViewModifier {
    @Binding var error: ErrorState?
    let duration: TimeInterval
    
    let position: ToastPosition = .top
    let toastMode: ToasMode
    
//    init(error: Binding<ErrorState?>, position: ToastPosition = .top, toastMode: ToasMode = .error, duration: TimeInterval) {
//        self.error = error
//        self.duration = duration
//        self.position = position
//        self.toastMode = toastMode
//    }

    func body(content: Content) -> some View {
        ZStack {
            content
            
            if let error = error {
                VStack {
                    if position == .bottom { Spacer(minLength: 0) } // push UP from bottom
                    
                    ToastView(message: error.message, mode: toastMode)
                        .transition(.move(edge: position == .top ? .top : .bottom)
                            .combined(with: .opacity))
                        .onAppear {
                           // LoadingManager.shared.hide()
                            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                withAnimation {
                                    self.error = nil
                                }
                            }
                        }
                        .padding(.vertical, 10)
                    
                    if position == .top { Spacer(minLength: 0) } // push DOWN from top
                }
                .zIndex(1)
            }
        }
        .animation(.easeInOut, value: error)
    }
}

struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    let duration: TimeInterval
    
    let position: ToastPosition = .top
    let toastMode: ToasMode

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                VStack {
                    Spacer()
                    ToastView(message: message, mode: toastMode)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                withAnimation {
                                    isPresented = false
                                }
                            }
                        }
                        .padding(.bottom, 40)
                }
                .zIndex(1)
            }
        }
        .animation(.easeInOut, value: isPresented)
    }
}
