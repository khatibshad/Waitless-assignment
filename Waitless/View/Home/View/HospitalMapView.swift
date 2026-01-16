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
                VStack(alignment: .leading, spacing: 2) {
                    Image(systemName: "h.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.main)

                    HStack {
                        HStack {
                            Text("21\nKM")
                                .font(.caption)
                                .foregroundColor(.main)
                                .multilineTextAlignment(.center)
                                .background(Color.white)
                                .padding(.leading, 8)
                                
                            HStack {
                                Image(systemName: "clock")
                                    .foregroundColor(.white)
                                VStack {
                                    Text(hospital.time)
                                        .font(.caption)
                                        .foregroundColor(.white)
                                    Text("Waiting Time")
                                        .font(.caption2)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(4)

                            .frame(maxHeight: .infinity)
                            .background(Color.main)
                        }
                    }
                    //.padding(8)
                    .background(Color.white)
                    .clipShape(
                        RoundedCorner(radius: 8, corners: .allCorners)
                    )
                }
            }
        }
        .cornerRadius(16)
    }
}


#Preview {
    HospitalMapView(locationManager: .init())
}
