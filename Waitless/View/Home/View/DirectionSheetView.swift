//
//  DirectionSheetView.swift
//  Waitless
//
//  Created by shayan khatibshad on 2026-01-16.
//

import SwiftUI

struct DirectionSheetView: View {
    
    let hospital: Hospital
    
    @State private var showApps: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                specialtyTag
                Spacer()
                WATextView(text: "Last updated 15 min ago", textColor: .textSecondary)
            }
            
            HStack {
                Circle()
                    .fill(Color.init(hex: "#B71C1C"))
                    .frame(width: 16)
                WATextView(text: "General", textColor: .textSecondary)

                Spacer()
                HStack(spacing: 6) {
                    Image("ic-star")
                    Text("4.8")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                }
            }
            
            itemView(title: "2 hr 46 min waiting time", icon: "ic-timeline")
            itemView(title: "8.1 Km", icon: "ic-location")
            itemView(title: "Available", icon: "ic-park")
            HStack() {
                itemView(title: "18 min", icon: "ic-car")
                itemView(title: "32 min", icon: "ic-bus")
                itemView(title: "1 hr 45 min", icon: "ic-person")
                Spacer()
            }
            
            Spacer()
            
            WAButtonView(title: "Get Direction", action: {
                showApps = true
            }, style: .background(bgColor: .main, textColor: .white))
        }
        .padding()
        .padding(.horizontal, 12)
        
        .sheet(isPresented: $showApps) {
            SelectMapAppView(hospital: hospital)
                .presentationDetents([.height(200)])
                .presentationCornerRadius(12)
                .presentationDragIndicator(.visible)
        }
    }
    
    func itemView(title: String, icon: String) -> some View {
        HStack(spacing: 6) {
            Image(icon)
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.textSecondary)
            //Spacer()
        }
    }
    
    var specialtyTag: some View {
        HStack {
            Image("ic-verify-badge")
            Text("Multi-specialty")
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
    
}

#Preview {
    DirectionSheetView(hospital: .local[0])
}
