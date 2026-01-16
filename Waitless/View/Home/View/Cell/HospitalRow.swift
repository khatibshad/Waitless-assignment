//
//  HospitalRow.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import SwiftUI

struct HospitalRow: View {
    
    let hospital: Hospital
    var isSelected: Bool
    
    @State var textColor: Color = Color.textGray
    
    var body: some View {
        HStack(spacing: 24) {
            WATextView(text: "H", style: .custom(style: .init(font: .system(size: 25, weight: .bold), normalColor: .white, selectedColor: nil, disabledColor: nil)), textColor: .white)
                .padding()
                .background(isSelected ? .main : .textGray)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 5) {
                WATextView(text: hospital.name, style: .title, textColor: getColor())
                HStack {
                    VStack(alignment: .leading) {
                        WATextView(text: hospital.distance, style: .caption, textColor: getColor())
                        WATextView(text: "km", style: .caption, textColor: getColor())
                    }
                    VStack(alignment: .leading) {
                        WATextView(text: hospital.time, style: .caption, textColor: getColor())
                        WATextView(text: "Waiting Time", style: .caption, textColor: getColor())
                    }
                    Spacer()
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        //.padding(.horizontal)
    }
    
    func getColor() -> Color {
        return isSelected ? .main : .textGray
    }
}

#Preview {
    HospitalRow(hospital: Hospital.local[0], isSelected: false)
}
