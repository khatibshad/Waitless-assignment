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
    @Published var selectedHospital: Hospital?
}

struct HomeView: View {
    
    @EnvironmentObject var coordinator: MainCoordinator
    @ObservedObject var vm: HomeViewModel = .init()
    @State private var presentDirectionView: Bool = false
    //@State private var selectedHospital: Hospital?
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                WATextField(placeholder: "Search", text: $vm.search, cornerRadius: 24, rightView: .init(image: Image("search"), action: {
                    coordinator.push(FilterView(), title: nil)
                }))
                VStack {
                    // MapView
                    HospitalMapView(
                        locationManager: vm.locationManage, selectedHospital: $vm.selectedHospital, actionHandler: {
                            presentDirectionView = true
                        })
                    .frame(maxHeight: .infinity)
                    HospitalListView(vm: .init(selectedHospital: vm.selectedHospital) ,selectAction: { hospital in
                        vm.selectedHospital = hospital
                    })
                        .frame(height: 350)
                    Spacer()
                    //BottomView
                }
            }
            
//            HospitalListView(vm: .init(selectedHospital: vm.selectedHospital) ,selectAction: { hospital in
//                vm.selectedHospital = hospital
//            })
//                .frame(height: 350)
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
        .sheet(isPresented: $presentDirectionView) {
            DirectionSheetView()
                .presentationDetents([.height(300)])
                .presentationCornerRadius(24)
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(MainCoordinator())
}
