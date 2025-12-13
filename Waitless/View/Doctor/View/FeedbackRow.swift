//
//  FeedbackRow.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import SwiftUI

struct FeedbackRow: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image("dr-1")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 8) {
                    WATextView(text: "Sarah Ahmad", style: .title)
                    WATextView(text: "2024/03/14 , 23:30 p.m", style: .caption)
                }
                Spacer()
            }
            WATextView(text: "Such an inspiring and knowledgeable doctor!", style: .caption)
        }
        .padding(8)
        .background(Color.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
    }
}

#Preview {
    FeedbackRow()
}
