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
    
    @EnvironmentObject var onboardingManager: OnboardingManager
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
    
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            
//            CoordinatorContainer(coordinator: homeCoordinator, rootView: HomeView(), transparent: false, title: "Home")
//                .tabItem {
//                    tabItem(
//                        tab: .home,
//                        icon: "house",
//                        title: "Home"
//                    )
//                }
//                .tag(WATab.home)
//            
//            CoordinatorContainer(coordinator: doctorCoordinator, rootView: DoctorsView(), transparent: false, title: "Doctors")
//                .tabItem {
//                    tabItem(
//                        tab: .people,
//                        icon: "person.3",
//                        title: "People"
//                    )
//                }
//                .tag(WATab.people)
//            
//            LoginView()
//                .tabItem {
//                    tabItem(
//                        tab: .profile,
//                        icon: "person.fill",
//                        title: "Profile"
//                    )
//                }
//                .tag(WATab.profile)
//        }
//        .tint(.main)
//    }
    
    
    var body: some View {
        ZStack {
            // Main TabView
            tabViews()
            // Overlay onboarding if needed
            if !onboardingManager.hasSeenOnboarding {
                OnboardView()
                    .transition(.opacity)
                    .zIndex(1) // Ensure it's on top
            }
        }
        .animation(.easeInOut(duration: 0.3), value: onboardingManager.hasSeenOnboarding)
        .background(Color.gray)
        .edgesIgnoringSafeArea(.all)
    }
    
    func tabViews() -> some View {
        ZStack(alignment: .bottom) {
            // MARK: - Main Tab Views
            Group {
                switch selectedTab {
                case .home:
                    CoordinatorContainer(coordinator: homeCoordinator, rootView: HomeView(), transparent: false, title: "Home")
                case .people:
                    CoordinatorContainer(coordinator: doctorCoordinator, rootView: DoctorsView(), transparent: false, title: "Doctors")
                case .profile:
                    CoordinatorContainer(coordinator: profileCoordinator, rootView: LoginView(), transparent: false, title: "Profile")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, currentCoordinator?.isTabBarHidden == true ? 0 : 60)
            .edgesIgnoringSafeArea(.top)
            
            // MARK: - Custom Tab Bar
            if currentCoordinator?.isTabBarHidden == false {
                HStack(spacing: 12) {
                    tabItem(
                        tab: .home,
                        icon: "house",
                        title: "Home"
                    )
                    .onTapGesture {
                        selectedTab = .home
                    }
                    
                    Spacer()
                    
                    tabItem(
                        tab: .people,
                        icon: "person.3",
                        title: "People"
                    )
                    .onTapGesture {
                        selectedTab = .people
                    }
                    
                    Spacer()
                    
                    tabItem(
                        tab: .profile,
                        icon: "person.fill",
                        title: "Profile"
                    )
                    .onTapGesture {
                        selectedTab = .profile
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: -2)
                )
                .padding(.horizontal, 25)
                .padding(.bottom, 12)
            }
        }
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
