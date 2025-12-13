//
//  ContentView.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import SwiftUI

struct ContentView: View {
    
    enum WATab {
        case home
        case people
        case profile
    }
    
    @State private var selectedTab: WATab = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            HomeView()
                .tabItem {
                    tabItem(
                        tab: .home,
                        icon: "house",
                        title: "Home"
                    )
                }
                .tag(WATab.home)
            
            DoctorsView()
                .tabItem {
                    tabItem(
                        tab: .people,
                        icon: "person.3",
                        title: "People"
                    )
                }
                .tag(WATab.people)
            
            LoginView()
                .tabItem {
                    tabItem(
                        tab: .profile,
                        icon: "person.fill",
                        title: "Profile"
                    )
                }
                .tag(WATab.profile)
        }
        .tint(.red)
    }
    
    @ViewBuilder
    private func tabItem(
        tab: WATab,
        icon: String,
        title: String
    ) -> some View {

        if selectedTab == tab {
            VStack(spacing: 2) {
                Image(systemName: icon)
                Text(title)
                    .font(.system(size: 11, weight: .semibold))
            }
        } else {
            Image(systemName: icon)
        }
    }

    
}

#Preview {
    ContentView()
}
