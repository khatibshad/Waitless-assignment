//
//  LocationManager.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import Foundation
import CoreLocation
import MapKit

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 43.7615, longitude: -79.4111),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    private let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestPermission() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else { return }
        region.center = location.coordinate
    }
}
