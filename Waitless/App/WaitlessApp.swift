//
//  WaitlessApp.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import SwiftUI

@main
struct WaitlessApp: App {
    
    @StateObject private var coordinator = MainCoordinator()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
