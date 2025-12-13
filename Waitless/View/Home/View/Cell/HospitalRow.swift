//
//  HospitalRow.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import SwiftUI

struct HospitalRow: View {
    
    var body: some View {
        HStack(spacing: 24) {
            WATextView(text: "H", style: .custom(style: .init(font: .headline, normalColor: .white, selectedColor: nil, disabledColor: nil)))
                .padding()
                .background(Color.red)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 5) {
                WATextView(text: "North York General Hospital", style: .title)
                HStack {
                    VStack(alignment: .leading) {
                        WATextView(text: "10", style: .caption, textColor: WAColor.textSecondary)
                        WATextView(text: "km", style: .caption, textColor: WAColor.textSecondary)
                    }
                    VStack(alignment: .leading) {
                        WATextView(text: "21 min", style: .caption, textColor: WAColor.textSecondary)
                        WATextView(text: "Waiting Time", style: .caption, textColor: WAColor.textSecondary)
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
}

#Preview {
    HospitalRow()
}
