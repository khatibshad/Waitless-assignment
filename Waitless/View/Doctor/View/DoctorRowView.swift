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
            Text(doctor.specialty)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.blue)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(Color.blue.opacity(0.15))
                )
        }
    
    var body: some View {
        VStack {
            HStack {
                Image(doctor.imageName)
                    .scaledToFill()
                    //.frame(width: 72)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                VStack(alignment: .leading) {
                    WATextView(text: doctor.name, style: .title)
                    specialtyTag
                    infoRow(icon: "star.fill", text: "\(doctor.rating)", color: .orange)
                    infoRow(icon: "clock", text: doctor.time)
                    infoRow(icon: "mappin", text: doctor.hospital)
                }
                Spacer()
            }
            
            WAButtonView(title: "View details", action: {
                
            }, style: .border(bgColor: .white, textColor: .red, borderColor: .red))
            
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
               Image(systemName: icon)
                   .foregroundColor(color)
                   .font(.system(size: 15))

               Text(text)
                   .font(.system(size: 10))
                   .foregroundColor(.gray)
           }
       }
}

#Preview {
    DoctorRowView(doctor: Doctor.doctors.first!)
}
