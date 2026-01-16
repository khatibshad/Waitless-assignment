//
//  HospitalMapView.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import SwiftUI
import MapKit

struct HospitalMapView: View {

    @ObservedObject var locationManager: LocationManager
    let hospitals: [Hospital] = Hospital.local
    @Binding var selectedHospital: Hospital?
    let actionHandler: (_ hospital: Hospital) -> Void
    @State private var showingHospitalCard: Bool = false
    
    var body: some View {
        Map(
            coordinateRegion: $locationManager.region,
            showsUserLocation: true,
            annotationItems: hospitals
        ) { hospital in
            MapAnnotation(coordinate: hospital.coordinate) {
                ZStack(alignment: .bottom) {
                    Image(systemName: "h.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.main)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                if selectedHospital?.id == hospital.id {
                                    selectedHospital = nil
                                    showingHospitalCard = false
                                } else {
                                    // Select new hospital
                                    selectedHospital = hospital
                                    showingHospitalCard = true
                                    centerMapOnHospital(hospital)
                                    actionHandler(hospital)
                                }
                            }
                        }
                    // Show HStack when this hospital is selected
                    if showingHospitalCard && selectedHospital?.id == hospital.id {
                        HospitalInfoCard(hospital: hospital)
                            .background(Color.white)
                            .clipShape(
                                RoundedCorner(radius: 8, corners: .allCorners)
                            )
                            .transition(.scale.combined(with: .opacity))
                            .offset(y: 40)
                            .offset(x: 60)
                    }
                }
            }
        }
        .cornerRadius(16)
        .onChange(of: selectedHospital) { hospital in
            if let hospital = hospital {
                centerMapOnHospital(hospital)
            }
        }
        .ignoresSafeArea()
    }
    
    private func centerMapOnHospital(_ hospital: Hospital) {
        withAnimation(.easeInOut) {
            locationManager.region = MKCoordinateRegion(
                center: hospital.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        }
    }
    
    private func calculateDistance(from: CLLocationCoordinate2D?, to: CLLocationCoordinate2D) -> Double {
        guard let from = from else { return 0 }
        let fromLocation = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let toLocation = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return fromLocation.distance(from: toLocation) / 1000 // Convert to KM
    }
}


#Preview {
    HospitalMapView(locationManager: .init(), selectedHospital: .constant(.local[0]), actionHandler: {_ in})
}

struct HospitalInfoCard: View {
    let hospital: Hospital
    
    var body: some View {
        HStack() {
            Text("\(hospital.distance)\nKM")
                .font(.caption)
                .foregroundColor(.main)
                .multilineTextAlignment(.leading)
                .background(Color.white)
                .padding(.leading, 8)
                
            HStack {
                Image(systemName: "clock")
                    .foregroundColor(.white)
                VStack(alignment: .leading) {
                    Text(hospital.time)
                        .font(.system(size: 11))
                        .foregroundColor(.white)
                    Text("Waiting Time")
                        .font(.system(size: 8))
                        .foregroundColor(.white)
                }
            }
            .padding(4)

            .frame(maxHeight: .infinity)
            .background(Color.main)
        }
    }
}

enum NavigationApp {
    case appleMaps
    case googleMaps
    case waze
    case citymapper
    case mapQuest
    
    var name: String {
        switch self {
        case .appleMaps: return "Apple Maps"
        case .googleMaps: return "Google Maps"
        case .waze: return "Waze"
        case .citymapper: return "Citymapper"
        case .mapQuest: return "MapQuest"
        }
    }
    
    var icon: String {
        switch self {
        case .appleMaps: return "map.fill"
        case .googleMaps: return "g.circle.fill"
        case .waze: return "w.circle.fill"
        case .citymapper: return "building.2.fill"
        case .mapQuest: return "m.circle.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .appleMaps: return .blue
        case .googleMaps: return .green
        case .waze: return .blue
        case .citymapper: return .purple
        case .mapQuest: return .orange
        }
    }
    
    var urlScheme: String {
        switch self {
        case .appleMaps: return "maps://"
        case .googleMaps: return "comgooglemaps://"
        case .waze: return "waze://"
        case .citymapper: return "citymapper://"
        case .mapQuest: return "mapquest://"
        }
    }
    
    func isInstalled() -> Bool {
        guard let url = URL(string: urlScheme) else { return false }
        return UIApplication.shared.canOpenURL(url)
    }
}

class NavigationManager: ObservableObject {
    func openInNavigationApp(_ app: NavigationApp,
                           coordinate: CLLocationCoordinate2D,
                           label: String? = nil,
                           startCoordinate: CLLocationCoordinate2D? = nil) {
        
        switch app {
        case .appleMaps:
            openInAppleMaps(coordinate: coordinate, label: label)
        case .googleMaps:
            openInGoogleMaps(coordinate: coordinate, label: label, startCoordinate: startCoordinate)
        case .waze:
            openInWaze(coordinate: coordinate)
        case .citymapper:
            openInCitymapper(coordinate: coordinate, label: label)
        case .mapQuest:
            openInMapQuest(coordinate: coordinate, label: label)
        }
    }
    
    // MARK: - Apple Maps
    func openInAppleMaps(coordinate: CLLocationCoordinate2D, label: String? = nil) {
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = label
        
        let launchOptions: [String: Any] = [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
            MKLaunchOptionsShowsTrafficKey: true
        ]
        
        mapItem.openInMaps(launchOptions: launchOptions)
    }
    
    // MARK: - Google Maps
    func openInGoogleMaps(coordinate: CLLocationCoordinate2D,
                         label: String? = nil,
                         startCoordinate: CLLocationCoordinate2D? = nil) {
        
        let lat = coordinate.latitude
        let lng = coordinate.longitude
        let labelEncoded = label?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        var urlString = "comgooglemaps://?daddr=\(lat),\(lng)&directionsmode=driving"
        
        if let startCoordinate = startCoordinate {
            urlString += "&saddr=\(startCoordinate.latitude),\(startCoordinate.longitude)"
        }
        
        if !labelEncoded.isEmpty {
            urlString += "&q=\(labelEncoded)"
        }
        
        guard let url = URL(string: urlString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            // Fallback to web version
            let webUrlString = "https://www.google.com/maps/dir/?api=1&destination=\(lat),\(lng)&travelmode=driving"
            if let webUrl = URL(string: webUrlString) {
                UIApplication.shared.open(webUrl, options: [:], completionHandler: nil)
            }
        }
    }
    
    // MARK: - Waze
    func openInWaze(coordinate: CLLocationCoordinate2D) {
        let lat = coordinate.latitude
        let lng = coordinate.longitude
        
        // Waze URL format: waze://?ll=lat,lng&navigate=yes
        let urlString = "waze://?ll=\(lat),\(lng)&navigate=yes"
        
        guard let url = URL(string: urlString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            // Fallback to App Store
            let appStoreUrl = URL(string: "https://apps.apple.com/app/waze-navigation-live-traffic/id323229106")!
            UIApplication.shared.open(appStoreUrl, options: [:], completionHandler: nil)
        }
    }
    
    // MARK: - Citymapper
    func openInCitymapper(coordinate: CLLocationCoordinate2D, label: String? = nil) {
        let lat = coordinate.latitude
        let lng = coordinate.longitude
        let labelEncoded = label?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        var urlString = "citymapper://directions?endcoord=\(lat),\(lng)"
        
        if !labelEncoded.isEmpty {
            urlString += "&endname=\(labelEncoded)"
        }
        
        guard let url = URL(string: urlString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    // MARK: - MapQuest
    func openInMapQuest(coordinate: CLLocationCoordinate2D, label: String? = nil) {
        let lat = coordinate.latitude
        let lng = coordinate.longitude
        let labelEncoded = label?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        var urlString = "mapquest://maps/directions?to=\(lat),\(lng)"
        
        if !labelEncoded.isEmpty {
            urlString += "&name=\(labelEncoded)"
        }
        
        guard let url = URL(string: urlString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    // MARK: - Open with all available options
    func showNavigationOptions(coordinate: CLLocationCoordinate2D,
                             label: String? = nil,
                             startCoordinate: CLLocationCoordinate2D? = nil) -> [NavigationApp] {
        
        var availableApps: [NavigationApp] = []
        
        // Apple Maps is always available on iOS
        availableApps.append(.appleMaps)
        
        // Check other apps
        let appsToCheck: [NavigationApp] = [.googleMaps, .waze, .citymapper, .mapQuest]
        
        for app in appsToCheck {
            if app.isInstalled() {
                availableApps.append(app)
            }
        }
        
        return availableApps
    }
}
