//
//  WARadioButtonView.swift
//  Waitless
//
//  Created by shayan khatibshad on 2026-01-16.
//

import SwiftUI

struct WARadioButtonView: View {
    let title: String
    @Binding var isSelected: Bool
    
    var body: some View {
        HStack {
            ZStack {
                // background + border
                RoundedRectangle(cornerRadius: 8.0)
                    .fill(isSelected ? Color.main : .white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8.0)
                            .stroke(Color.main, lineWidth: 2.0)
                    )
                
                // checkmark
                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .frame(width: 20, height: 20)
            .onTapGesture {
                isSelected.toggle()
            }
            
            WATextView(text: title)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
    }
}

#Preview("Custom Sizes") {
    Group {
        WARadioButtonView(title: "Neurology", isSelected: .constant(true))
            .previewLayout(.fixed(width: 150, height: 60))
        
        WARadioButtonView(title: "Neurology", isSelected: .constant(false))
            .previewLayout(.fixed(width: 250, height: 100))
    }
}
