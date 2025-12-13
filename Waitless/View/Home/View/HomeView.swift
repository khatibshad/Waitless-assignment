//
//  HomeView.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import SwiftUI
import MapKit
import CoreLocation

class HomeViewModel: ObservableObject {
    @Published var search = ""
    @Published var locationManage = LocationManager()
}

struct HomeView: View {
    
    @ObservedObject var vm: HomeViewModel = .init()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                WATextField(placeholder: "Search", text: $vm.search)
                VStack {
                    // MapView
                    HospitalMapView(
                        locationManager: .init())
                    .frame(maxHeight: .infinity)
                    
                    Spacer()
                    //BottomView
                }
            }
            
            HospitalListView()
                .frame(height: 350)
        }
        .clipShape(
            RoundedCorner(radius: 14, corners: [.bottomLeft, .bottomRight])
        )
        .padding()
        .navigationTitle("Find Hospital")
    }
}

#Preview {
    HomeView()
}
