//
//  SectionCard.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import SwiftUI

struct SectionCard<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.headline)
                .padding(.bottom)
            Divider()
            content
                .padding()
                .background(Color.init(hex: "#F8F8F8"))
            Divider()
        }
        .padding(8)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
