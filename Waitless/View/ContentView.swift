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
    
    @StateObject var homeCoordinator = MainCoordinator()
    @StateObject var doctorCoordinator = MainCoordinator()
    @StateObject var profileCoordinator = MainCoordinator()
    
    var currentCoordinator: MainCoordinator? {
        switch selectedTab {
        case .home:
            return homeCoordinator
        case .people:
            return doctorCoordinator
        case .profile:
            return profileCoordinator
        }
    }

    
    @State private var selectedTab: WATab = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            CoordinatorContainer(coordinator: homeCoordinator, rootView: HomeView(), transparent: false, title: "Home")
                .tabItem {
                    tabItem(
                        tab: .home,
                        icon: "house",
                        title: "Home"
                    )
                }
                .tag(WATab.home)
            
            CoordinatorContainer(coordinator: doctorCoordinator, rootView: DoctorsView(), transparent: false, title: "Doctors")
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
        .tint(.main)
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
