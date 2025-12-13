//
//  FindView.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import SwiftUI

struct DoctorsView: View {
    
    @EnvironmentObject var coordinator: MainCoordinator
    @State var search: String = ""
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(spacing: 12) {
                WATextField(placeholder: "Search", text: $search)
                    .padding(.horizontal)
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 0) {
                        ForEach(Doctor.doctors) { doc in
                            DoctorRowView(doctor: doc)
                                .onTapGesture {
                                    coordinator.push(DoctorView(doctor: doc))
                                }
                        }
                    }
                }
                .background(Color.white)
            }
            
        }
        .navigationTitle("test")
        .background(Color.white)
    }
}

#Preview {
    DoctorsView()
}
