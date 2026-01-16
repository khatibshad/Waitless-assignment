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
                HStack(spacing: 0) {
                    WATextField(placeholder: "Search", text: $search, cornerRadius: 24, rightView: .init(image: Image("search"), action: {}))
                        .padding(.horizontal)
                    WAButtonView(title: "", action: {
                        
                    }, style: .regular(textColor: .main), image: Image("ic-filter"))
                    .frame(width: 40)

                }
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 0) {
                        ForEach(Doctor.doctors) { doc in
                            DoctorRowView(doctor: doc)
                                .onTapGesture {
                                    coordinator.push(DoctorView(doctor: doc), title: "Doctors")
                                }
                        }
                    }
                }
                .background(Color.white)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                    } label: {
                        Image("ic-notification")
                            .renderingMode(.template)
                    }

                    Button {
                    } label: {
                        Image("ic-lang")
                            .renderingMode(.template)
                    }
                }
            }
            
        }
        .background(Color.white)
        
    }
}

#Preview {
    DoctorsView()
}
