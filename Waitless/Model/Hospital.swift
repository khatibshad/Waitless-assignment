//
//  Hospital.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import Foundation
import CoreLocation

struct Hospital: Identifiable, Equatable {
    let id: UUID
    let name: String
    let coordinate: CLLocationCoordinate2D
    let distance: String
    let time: String
    
    static func == (lhs: Hospital, rhs: Hospital) -> Bool {
        lhs.id == rhs.id
    }
    
    static var local: [Hospital] = [
        .init(
            id: UUID(),
            name: "North York General Hospital",
            coordinate: .init(latitude: 43.7615, longitude: -79.4111),
            distance: "10 KM",
            time: "21 min"
        ),
        .init(
            id: UUID(),
            name: "Markham Diagnostic Centre",
            coordinate: .init(latitude: 43.7705, longitude: -79.3711),
            distance: "12 KM",
            time: "16 min"
        ),
        .init(
            id: UUID(),
            name: "SM Medical",
            coordinate: .init(latitude: 43.7450, longitude: -79.3900),
            distance: "23 KM",
            time: "32 min"
        ),
        
        .init(
            id: UUID(),
            name: "North York General Hospital",
            coordinate: .init(latitude: 43.7615, longitude: -79.4111),
            distance: "10 KM",
            time: "21 min"
        ),
        .init(
            id: UUID(),
            name: "Markham Diagnostic Centre",
            coordinate: .init(latitude: 43.7705, longitude: -79.3711),
            distance: "12 KM",
            time: "16 min"
        ),
        .init(
            id: UUID(),
            name: "SM Medical",
            coordinate: .init(latitude: 43.7450, longitude: -79.3900),
            distance: "23 KM",
            time: "32 min"
        )
    ]
}

