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
    let actionHandler: () -> Void
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
                                    actionHandler()
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
    HospitalMapView(locationManager: .init(), selectedHospital: .constant(.local[0]), actionHandler: {})
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
