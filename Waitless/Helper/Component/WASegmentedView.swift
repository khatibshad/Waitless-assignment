//
//  WASegmentedView.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import SwiftUI

struct WASegmentedView<T: Hashable>: View {

    let items: [T]
    @Binding var selection: T
    let title: (T) -> String

    var body: some View {
        HStack(spacing: 0) {
            ForEach(items, id: \.self) { item in
                segmentButton(item)
            }
        }
    }
}

private extension WASegmentedView {

    func segmentButton(_ item: T) -> some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                selection = item
            }
        } label: {
            Text(title(item))
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(
                    selection == item ? .black : .gray
                )
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(
                    ZStack {
                        RoundedCorner(radius: 12, corners: [.topLeft, .topRight])
                            .fill(selection == item ? Color.init(hex: "#EAE8E8") : .white)
                    }
                )
        }
    }
}
