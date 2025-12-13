//
//  Hospital.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import Foundation
import CoreLocation

struct Hospital: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let distance: String
    let time: String
    
    static var local: [Hospital] = [
        .init(
            name: "North York General Hospital",
            coordinate: .init(latitude: 43.7615, longitude: -79.4111),
            distance: "10 KM",
            time: "21 min"
        ),
        .init(
            name: "Markham Diagnostic Centre",
            coordinate: .init(latitude: 43.7705, longitude: -79.3711),
            distance: "12 KM",
            time: "16 min"
        ),
        .init(
            name: "SM Medical",
            coordinate: .init(latitude: 43.7450, longitude: -79.3900),
            distance: "23 KM",
            time: "32 min"
        ),
        
        .init(
            name: "North York General Hospital",
            coordinate: .init(latitude: 43.7615, longitude: -79.4111),
            distance: "10 KM",
            time: "21 min"
        ),
        .init(
            name: "Markham Diagnostic Centre",
            coordinate: .init(latitude: 43.7705, longitude: -79.3711),
            distance: "12 KM",
            time: "16 min"
        ),
        .init(
            name: "SM Medical",
            coordinate: .init(latitude: 43.7450, longitude: -79.3900),
            distance: "23 KM",
            time: "32 min"
        )
    ]
}

