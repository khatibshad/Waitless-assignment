//
//  Coordinator.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import Foundation
import UIKit
import SwiftUI

struct CoordinatorContainer<Content: View>: UIViewControllerRepresentable {
    @ObservedObject var coordinator: MainCoordinator
    let rootView: Content
    let transparent: Bool
    
    func makeUIViewController(context: Context) -> UINavigationController {
        if transparent {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
        } else {
            setupNavigationBarAppearance(backgroundColor: UIColor.white, titleColor: UIColor.red)
        }
        
        let hosting = UIHostingController(rootView: rootView.environmentObject(coordinator))
        coordinator.navigationController.viewControllers = [hosting]
        return coordinator.navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // Nothing needed here for now
    }
    
    func setupNavigationBarAppearance(
        backgroundColor: UIColor,
        titleColor: UIColor = .red,
        largeTitleColor: UIColor = .red
    ) {
        let appearance = UINavigationBarAppearance()
        appearance.backButtonAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: -1000, vertical: 0)
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.shadowColor = .clear // removes the separator
        appearance.titleTextAttributes = [.foregroundColor: titleColor, .font: UIFont.systemFont(ofSize: 22, weight: .medium)]
        appearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = titleColor // back button color
    }
}

let navigationBarAppearance: UINavigationBarAppearance = {
    let titleColor = UIColor.red
    let largeTitleColor: UIColor = .red
    let appearance = UINavigationBarAppearance()
    appearance.backButtonAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: -1000, vertical: 0)
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor.white
    appearance.shadowColor = .clear // removes the separator
    appearance.titleTextAttributes = [.foregroundColor: titleColor, .font: UIFont.systemFont(ofSize: 22)]
    appearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
    
    return appearance
}()

class MainCoordinator: ObservableObject {
    @Published var isTabBarHidden: Bool = false
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    // Push a SwiftUI view
    func push<Content: View>(_ view: Content, animated: Bool = true) {
        let hosting = UIHostingController(rootView: view.toolbar(.visible, for: .navigationBar).environmentObject(self))
        navigationController.pushViewController(hosting, animated: animated)
    }
    
    // Present a SwiftUI view modally
    func present<Content: View>(_ view: Content, animated: Bool = true) {
        let hosting = UIHostingController(rootView: view.environmentObject(self))
        navigationController.present(hosting, animated: animated)
    }
    
    // Pop back
    func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    // Dismiss modally presented view
    func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: animated)
    }
    
    func setupNavigationBarAppearance(
        backgroundColor: UIColor,
        titleColor: UIColor = .red,
        largeTitleColor: UIColor = .red
    ) {
        let appearance = UINavigationBarAppearance()
        appearance.backButtonAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: -1000, vertical: 0)
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: titleColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = titleColor // back button color
    }
    
    func removeAllViews<Content: View>(_ view: Content?, animated: Bool = true) {
        guard let vc = self.navigationController.viewControllers.first else {
            return
        }
        if let view = view {
            let hosting = UIHostingController(rootView: view.environmentObject(self))
            self.navigationController.setViewControllers([vc, hosting], animated: true)
        } else {
            self.navigationController.setViewControllers([vc], animated: true)
        }
    }
    
    func removeAllViews(_ views: [any View], animated: Bool = true) {
        guard let vc = self.navigationController.viewControllers.first else {
            return
        }
        var stack: [UIViewController] = [vc]
        for view in views {
            let hosting = UIHostingController(rootView: AnyView(
                view.environmentObject(self)
            ))
            stack.append(hosting)
        }
        
        self.navigationController.setViewControllers(stack, animated: true)
    }
}

struct NavigationContainerView<Content: View>: UIViewControllerRepresentable {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let hosting = UIHostingController(rootView: content)
        
        let navController = UINavigationController(rootViewController: hosting)
        return navController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // update content if needed
        if let hosting = uiViewController.viewControllers.first as? UIHostingController<Content> {
            hosting.rootView = content
        }
    }
}
