//
//  SectionCard.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import SwiftUI

struct SectionCard<Content: View>: View {
    let title: String
    let titleIcon: String?
    
    @State var showDetail = true
    @ViewBuilder let content: Content

    init(title: String, titleIcon: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.titleIcon = titleIcon
        self.content = content()
    }
//    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                if let titleIcon {
                    Image(titleIcon)
                }
                Text(title)
                    .font(.headline)
                    .padding(.bottom)
                Spacer()
                Image(showDetail ?  "arrow-up" : "arrow-up")
                    .onTapGesture {
                        showDetail.toggle()
                    }
            }
            Divider()
            if showDetail {
                content
                    .padding()
                    .background(Color.init(hex: "#F8F8F8"))
                Divider()
            }
        }
        .padding(8)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
