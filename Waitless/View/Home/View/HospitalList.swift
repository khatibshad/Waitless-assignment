//
//  HospitalList.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import SwiftUI

class HospitalListViewModel: ObservableObject {
    
    enum Filter: String, CaseIterable {
        case nearest = "Nearest"
        case fastest = "Fastest"
    }
    
    @Published var mode: Filter = .nearest
    @Published var selectedHospital: Hospital?
    
}

struct HospitalListView: View {
    
    @ObservedObject var vm: HospitalListViewModel = .init()
    
    let hosipital: [Hospital] = Hospital.local
    
    var body: some View {
        ZStack {
            //Color.init(hex: "#EAE8E8").ignoresSafeArea()
            VStack(spacing: 0) {
                WASegmentedView(items: HospitalListViewModel.Filter.allCases, selection: $vm.mode, title: {$0.rawValue})
                Rectangle()
                    .fill(Color.init(hex: "#EAE8E8"))
                    .frame(height: 8)
                                  
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 12) {
                        ForEach(hosipital) { hospital in
                            HospitalRow(hospital: hospital, isSelected: vm.selectedHospital?.id == hospital.id)
                                .padding(.horizontal)
                                .onTapGesture {
                                    vm.selectedHospital = hospital
                                    print("hospital \(hospital.id)")
                                }
                        }
                    }
                }
                .background(Color.init(hex: "#EAE8E8").ignoresSafeArea())
                
                Spacer(minLength: 12)
            }
        }
    }
}

#Preview {
    HospitalListView()
}
