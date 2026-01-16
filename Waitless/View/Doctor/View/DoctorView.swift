//
//  DoctorView.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import SwiftUI

struct DoctorView: View {
    
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
        ScrollView {
            VStack {
                infoView()
                workingView()
                aboutView()
                educationView()
                feedbackView()
                Spacer()
                
            }
            .padding(8)
        }
        .background(Color.white)
    }
    
    func workingView() -> some View {
        SectionCard(title: "Working Hours & Address") {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image("ic-timeline")
                    WATextView(text: "09:00 a.m-13:30 p.m", style: .body, textColor: .textSecondary)
                    Spacer()
                }
                
                HStack {
                    Image("ic-location")
                    WATextView(text: "Sunnybrook  Hospital, 2075 Bayview Ave, North York, ON M4N 3M5, Canada", style: .body, textColor: .textSecondary)
                    Spacer()
                }
            }
        }
    }
    
    func aboutView() -> some View {
        SectionCard(title: "About") {
            WATextView(text: "LDr. Dennis Ko is a senior scientist and cardiologist at Sunnybrook Health Sciences Centre, specializing in cardiovascular care and outcomes research. With extensive academic and clinical affiliations... Read more", style: .body, textColor: .textSecondary)
                .frame(maxWidth: .infinity)
        }
    }
    
    func educationView() -> some View {
        SectionCard(title: "Education") {
            VStack(alignment: .leading, spacing: 8) {
                WATextView(text: "• MD, 1996, University of Ottawa, Canada", style: .body, textColor: .textSecondary, multilineAlignment: .leading)
                WATextView(text: "• Fellowship, 1999, internal medicine, Cleveland Clinic Foundation, U.S.", style: .body, textColor: .textSecondary)
                WATextView(text: "• Fellowship, 1999, internal medicine, Cleveland Clinic Foundation, U.S.", style: .body, textColor: .textSecondary)
                WATextView(text: "• Fellowship, 2002, cardiology, Yale University School of Medicine, U.S.", style: .body, textColor: .textSecondary)
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    func feedbackView() -> some View {
        SectionCard(title: "Patient Feedback") {
            VStack(alignment: .leading, spacing: 8) {
                FeedbackRow()
                FeedbackRow()
                FeedbackRow()
                FeedbackRow()
            }
        }
    }
    
    func infoView() -> some View {
        HStack {
            Image(doctor.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 70)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading) {
                WATextView(text: doctor.name, style: .custom(style: .init(font: .system(size: 16, weight: .bold), normalColor: .textBlack, selectedColor: .textBlack, disabledColor: .textBlack)))
                specialtyTag
                infoRow(icon: "ic-star", text: "\(doctor.rating)", color: .orange)
                
            }
            Spacer()
        }
    }
    
    func infoRow(icon: String, text: String, color: Color = .gray) -> some View {
        HStack(spacing: 6) {
            Image(icon)
            
            Text(text)
                .font(.system(size: 10))
                .foregroundColor(.textSecondary)
        }
    }
}

#Preview {
    DoctorView(doctor: Doctor.doctors.first!)
        .environmentObject(MainCoordinator())
}
