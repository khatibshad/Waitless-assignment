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
    
    init(selectedHospital: Hospital?) {
        self.selectedHospital = selectedHospital
    }
    
}

struct HospitalListView: View {
    
    @ObservedObject var vm: HospitalListViewModel = .init(selectedHospital: nil)
    let hosipital: [Hospital] = Hospital.local
    
    let selectAction: (_ hospital: Hospital?)-> Void
    
    init(vm: HospitalListViewModel, selectAction: @escaping (_: Hospital?) -> Void) {
        self.vm = vm
        self.selectAction = selectAction
    }
    
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
                                    selectAction(hospital)
                                }
                        }
                    }
                }
                .padding(.bottom)
                .background(Color.init(hex: "#EAE8E8").ignoresSafeArea())
                .clipShape(RoundedCorner(radius: 12, corners: [.bottomLeft, .bottomLeft]))
                
                Spacer(minLength: 12)
            }
        }
    }
}

#Preview {
    HospitalListView(vm: .init(selectedHospital: nil), selectAction: {_ in})
}
