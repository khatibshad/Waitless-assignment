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
    
    @EnvironmentObject var coordinator: MainCoordinator
    @ObservedObject var vm: HomeViewModel = .init()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                WATextField(placeholder: "Search", text: $vm.search, rightView: .init(image: Image("search"), action: {}))
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
        .onAppear {
            coordinator.navigationController.title = "Home"
        }
        .navigationTitle("Find Hospital")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    HomeView()
        .environmentObject(MainCoordinator())
}
