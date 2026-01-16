//
//  WaitlessApp.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import SwiftUI

@main
struct WaitlessApp: App {
    
    @StateObject private var onboardingManager = OnboardingManager()
    @StateObject private var coordinator = MainCoordinator()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(onboardingManager)
        }
    }
}

class OnboardingManager: ObservableObject {
    //@AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    @Published var hasSeenOnboarding: Bool = false
    
    func completeOnboarding() {
        hasSeenOnboarding = true
        objectWillChange.send()
    }
    
    func resetOnboarding() {
        hasSeenOnboarding = false
        objectWillChange.send()
    }
}
