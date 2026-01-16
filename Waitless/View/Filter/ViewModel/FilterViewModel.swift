//
//  FilterViewModel.swift
//  Waitless
//
//  Created by shayan khatibshad on 2026-01-16.
//

import Foundation

class FilterViewModel: ObservableObject {
    
    @Published var selectedSpecialtyFilter: [FilterViewModel.SpecialtyFilter] = []
    @Published var selectedHospitalType: FilterViewModel.HospitalType?
    
}

extension FilterViewModel {
    enum SpecialtyFilter: String, CaseIterable {
        case Neurology = "Neurology"
        case Gynecology = "Gynecology"
        case Cardiology = "Cardiology"
        case Multispecialty = "Multi-specialty"
    }
    
    enum HospitalType: String, CaseIterable {
        case `private` = "Private"
        case `public` = "Public"
    }
}
