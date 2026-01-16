//
//  SelectMapAppView.swift
//  Waitless
//
//  Created by shayan khatibshad on 2026-01-17.
//

import SwiftUI
import CoreLocation
import MapKit

struct SelectMapAppView: View {
    let hospital: Hospital
    @Environment(\.dismiss) private var dismiss
    @StateObject private var navigationManager = NavigationManager()
    @State private var selectedApp: NavigationApp?
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Spacer()
                VStack(alignment: .leading, spacing: 4) {
                    Text("Select an action")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            Divider()
            
            // Navigation Apps Grid
            ScrollView {
                VStack(spacing: 20) {
                    LazyVStack(spacing: 20) {
                        ForEach(navigationManager.showNavigationOptions(
                            coordinate: hospital.coordinate,
                            label: hospital.name), id: \.self) { app in
                                
                                NavigationAppButton(
                                    app: app,
                                    hospital: hospital,
                                    onSelect: { selectedApp = app }
                                )
                            }
                    }
                    .padding()
                }
            }
        }
        .background(Color(.systemBackground))
    }
    
    private func saveHospitalToContacts(_ hospital: Hospital) {
        // Implement contact saving logic
        print("Save hospital to contacts: \(hospital.name)")
    }
}

struct NavigationAppButton: View {
    let app: NavigationApp
    let hospital: Hospital
    let onSelect: () -> Void
    @StateObject private var navigationManager = NavigationManager()
    
    var body: some View {
        
        Button(action: {
            onSelect()
            navigationManager.openInNavigationApp(app,
                                                  coordinate: hospital.coordinate,
                                                  label: hospital.name)
        }) {
            WAButtonView(title: app.name, action: {
                onSelect()
                navigationManager.openInNavigationApp(app,
                                                                coordinate: hospital.coordinate,
                                                                label: hospital.name)
            }, style: .background(bgColor: .main, textColor: .white))
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct NavigationURLSchemes {
    static let schemes: [String: String] = [
        "Apple Maps": "maps://",
        "Google Maps": "comgooglemaps://",
        "Waze": "waze://",
        "Citymapper": "citymapper://",
        "MapQuest": "mapquest://",
        "Lyft": "lyft://",
        "Uber": "uber://",
        "Yandex Maps": "yandexnavi://",
        "Moovit": "moovit://",
        "Transit": "transit://",
        "Sygic": "com.sygic.aura://",
        "Here WeGo": "here-route://"
    ]
    
    static func isAppInstalled(_ appName: String) -> Bool {
        guard let scheme = schemes[appName],
              let url = URL(string: scheme) else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }
    
    static func getInstalledNavigationApps() -> [String] {
        return schemes.keys.filter { isAppInstalled($0) }
    }
}

#Preview {
    SelectMapAppView(hospital: .local[0])
}

