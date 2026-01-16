//
//  DoctorRowView.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import SwiftUI

struct DoctorRowView: View {
    
    let doctor: Doctor
    
    var specialtyTag: some View {
        HStack {
            Image("ic-verify-badge")
            Text(doctor.specialty)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.blue)
                
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(
            Capsule()
                .fill(Color.blue.opacity(0.15))
        )
        
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(doctor.imageName)
                    .scaledToFill()
                    //.frame(width: 72)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                VStack(alignment: .leading) {
                    WATextView(text: doctor.name, style: .custom(style: .init(font: .system(size: 16, weight: .bold), normalColor: .textBlack, selectedColor: .textBlack, disabledColor: .textBlack)))
                    specialtyTag
                    infoRow(icon: "ic-star", text: "\(doctor.rating)", color: .orange)
                    infoRow(icon: "ic-timeline", text: doctor.time)
                    infoRow(icon: "ic-location", text: doctor.hospital)
                }
                Spacer()
            }
            
            WAButtonView(title: "View details", action: {
                
            }, style: .border(bgColor: .white, textColor: .main, borderColor: .main))
            
        }
        .padding()
        .background(Color.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .shadow(radius: 3)
        .padding()
    }
    
    func infoRow(icon: String, text: String, color: Color = .gray) -> some View {
        HStack(spacing: 6) {
            Image(icon)
            Text(text)
                .font(.system(size: 14))
                .foregroundColor(.textSecondary)
        }
    }
}

#Preview {
    DoctorRowView(doctor: Doctor.doctors.first!)
}
