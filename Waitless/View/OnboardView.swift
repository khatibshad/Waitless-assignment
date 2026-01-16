//
//  OnboardView.swift
//  Waitless
//
//  Created by shayan khatibshad on 2026-01-16.
//

import SwiftUI

struct OnboardView: View {
    @EnvironmentObject var onboardingManager: OnboardingManager
    @Environment(\.colorScheme) var colorScheme
    @State private var showContent = false
    @State private var blurIntensity: Double = 0.5
    @State private var selectedMaterial: Material = .ultraThinMaterial
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                // Blur panel
                VStack(alignment: .center, spacing: 16) {
                    Spacer()
                    VStack {
                        Image("logo")
                            .renderingMode(.template)
                            .foregroundColor(.main)
                        WATextView(text: "Waitless\nER", style: .custom(style: .init(font: .system(size: 32, weight: .bold), normalColor: .main, selectedColor: .main, disabledColor: .main)), textColor: .main, multilineAlignment: .center)
                    }
                    .padding()
                    .background(selectedMaterial)
                    .cornerRadius(20)
                    
                    WATextView(text: "Quickly connect to the nearest\nemergency room", style: .custom(style: .init(font: .system(size: 20, weight: .bold), normalColor: .black, selectedColor: .black, disabledColor: .black)), textColor: .black, multilineAlignment: .center)
                    
                    WAButtonView(title: "Quick Access", action: {
                        withAnimation(.spring()) {
                            onboardingManager.completeOnboarding()
                        }
                    }, style: .background(bgColor: .main, textColor: .white))
                    
                    Spacer()
                        .frame(height: 30)
                    WATextView(text: "All wait-times, distances, and travel estimates shown in this app are approximate and may differ from real conditions. Actual wait-time may vary depending on hospital activity, staffing, and emergency priority", textColor: .black, multilineAlignment: .center)
                    Spacer()
                }
                .padding(24)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(selectedMaterial)
                .cornerRadius(20)
            }
        }
    }
}

#Preview {
    OnboardView()
}
