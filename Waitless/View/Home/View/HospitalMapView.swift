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

    var body: some View {
        Map(
            coordinateRegion: $locationManager.region,
            showsUserLocation: true,
            annotationItems: hospitals
        ) { hospital in
            MapAnnotation(coordinate: hospital.coordinate) {
                VStack(spacing: 2) {
                    Image(systemName: "h.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.red)

                    Text(hospital.name)
                        .font(.caption2)
                        .padding(4)
                        .background(Color.white)
                        .cornerRadius(6)
                }
            }
        }
        .cornerRadius(16)
    }
}


#Preview {
    HospitalMapView(locationManager: .init())
}
