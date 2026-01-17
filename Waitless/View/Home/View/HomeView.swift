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
    @State private var presentDirectionView: Hospital?
    @State private var sheetPosition: SheetPosition = .collapsed
    @State private var bottomSheetHeight: CGFloat = 0
    
    //@State private var selectedHospital: Hospital?
    var body: some View {
        ZStack {
            VStack {
                WATextField(placeholder: "Search", text: $vm.search, cornerRadius: 24, rightView: .init(image: Image("search"), action: {
                    coordinator.push(FilterView(), title: nil)
                }))
                VStack {
                    // MapView
                    HospitalMapView(
                        locationManager: vm.locationManage, selectedHospital: $vm.selectedHospital, bottomSheetHeight: $bottomSheetHeight, actionHandler: { hospital in
                            presentDirectionView = hospital
                        })
                    .frame(maxHeight: .infinity)
                    
                    //BottomView
                }
            }
            BottomSheet(position: $sheetPosition) {
                GeometryReader { geo in
                    let visibleHeight =
                                sheetPosition.visibleHeight(screenHeight: geo.size.height)
                    Color.clear
                                .onAppear {
                                    bottomSheetHeight = visibleHeight
                                }
                                .onChange(of: sheetPosition) { _ in
                                    bottomSheetHeight = visibleHeight
                                }
                    HospitalListView(
                        vm: .init(selectedHospital: vm.selectedHospital),
                        visibleHeight: visibleHeight,
                        selectAction: { hospital in
                            vm.selectedHospital = hospital
                        }
                    )
                }
            }
                        
        }
        .clipShape(
            RoundedCorner(radius: 14, corners: [.bottomLeft, .bottomRight])
        )
        .padding(.horizontal)
        .onAppear {
            coordinator.navigationController.title = "Home"
        }
        .navigationTitle("Find Hospital")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: Binding(get: { presentDirectionView != nil }, set: { newValue in
            if !newValue {
                presentDirectionView = nil
            }
        })) {
            DirectionSheetView(hospital: presentDirectionView!)
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
