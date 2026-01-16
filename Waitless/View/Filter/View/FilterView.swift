//
//  FilterView.swift
//  Waitless
//
//  Created by shayan khatibshad on 2026-01-16.
//

import SwiftUI

struct FilterView: View {
    
    @EnvironmentObject var coordinartor: MainCoordinator
    @ObservedObject var vm: FilterViewModel = .init()
    
    var body: some View {
        ScrollView {
            VStack {
                specialtyView()
                HospitalTypeRow()
            }
        }
    }
    
    func specialtyView() -> some View {
        SectionCard(title: "Hospital Type", titleIcon: "ic-tag") {
            VStack(alignment: .leading, spacing: 8) {
                ForEach(FilterViewModel.SpecialtyFilter.allCases, id: \.self) { column in
                    WARadioButtonView(title: column.rawValue, isSelected: Binding(
                        get: { vm.selectedSpecialtyFilter.contains(column) },
                        set: { isSelected in
                            if isSelected {
                                vm.selectedSpecialtyFilter.append(column)
                            } else {
                                vm.selectedSpecialtyFilter.removeAll { $0 == column }
                            }
                        }
                    ))
                }
            }
        }
    }
    
    func HospitalTypeRow() -> some View {
        SectionCard(title: "Hospital Type", titleIcon: "ic-tag") {
            VStack(alignment: .leading, spacing: 8) {
                ForEach(FilterViewModel.HospitalType.allCases, id: \.self) { column in
                    WARadioButtonView(title: column.rawValue, isSelected: Binding(
                        get: { vm.selectedHospitalType == column },
                        set: { isSelected in
                            if isSelected {
                                vm.selectedHospitalType = column
                            } else {
                                vm.selectedHospitalType = nil
                            }
                        }
                    ))
                }
            }
        }
    }
}

#Preview {
    FilterView()
        .environmentObject(MainCoordinator())
}
