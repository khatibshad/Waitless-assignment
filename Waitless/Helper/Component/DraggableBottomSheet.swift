//
//  DraggableBottomSheet.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import SwiftUI

struct DraggableBottomSheet<Content: View>: View {

    let content: Content
    let maxHeight: CGFloat = 420
    let minHeight: CGFloat = 160

    @GestureState private var translation: CGFloat = 0
    @State private var offset: CGFloat = 0

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        GeometryReader { geo in
            VStack {
                Capsule()
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 40, height: 5)
                    .padding(8)

                content
            }
            .frame(width: geo.size.width)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.init(hex: "#EAE8E8"))
                    .shadow(radius: 8)
            )
            .offset(y: max(offset + translation, geo.size.height - maxHeight))
            .gesture(
                DragGesture()
                    .updating($translation) { value, state, _ in
                        state = value.translation.height
                    }
                    .onEnded { value in
                        let snap = geo.size.height - minHeight
                        let expanded = geo.size.height - maxHeight

                        if offset + value.translation.height < snap {
                            offset = expanded
                        } else {
                            offset = snap
                        }
                    }
            )
        }
    }
}
