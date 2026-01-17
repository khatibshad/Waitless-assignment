//
//  AdvancedBottomSheet.swift
//  Waitless
//
//  Created by shayan khatibshad on 2026-01-17.
//

import SwiftUI


enum SheetPosition: CGFloat {
    case expanded  = 0.12
    case collapsed = 0.55
    case peek      = 0.88   // ≈ 100px visible
}

extension SheetPosition {
    func visibleHeight(screenHeight: CGFloat) -> CGFloat {
        screenHeight * (1 - rawValue)
    }
}

struct BottomSheet<Content: View>: View {

    @Binding var position: SheetPosition
    let content: Content

    @GestureState private var dragOffset: CGFloat = 0

    init(
        position: Binding<SheetPosition>,
        @ViewBuilder content: () -> Content
    ) {
        self._position = position
        self.content = content()
    }

    private func nextPosition(drag: CGFloat) -> SheetPosition {
        if drag < -80 {
            return position == .collapsed ? .expanded : .collapsed
        } else if drag > 80 {
            return position == .collapsed ? .peek : .collapsed
        }
        return position
    }

    var body: some View {
        GeometryReader { geo in
            let height = geo.size.height

            VStack(spacing: 0) {

                // 🔥 DRAG HANDLE ONLY
                VStack {
                    Capsule()
                        .fill(Color.gray.opacity(0.45))
                        .frame(width: 36, height: 5)
                        .padding(.vertical, 12)
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .frame(height: 50)
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            state = value.translation.height
                        }
                        .onEnded { value in
                            position = nextPosition(drag: value.translation.height)
                        }
                )
                
                content
                    .frame(maxHeight: .infinity, alignment: .top)
            }
            .frame(height: height)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(.systemBackground))
            )
            .offset(y: height * position.rawValue + dragOffset)
            .animation(.interactiveSpring(response: 0.32), value: position)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

//struct SheetScrollView<Content: View>: View {
//
//    let isExpanded: Bool
//    let content: Content
//
//    init(isExpanded: Bool, @ViewBuilder content: () -> Content) {
//        self.isExpanded = isExpanded
//        self.content = content()
//    }
//
//    var body: some View {
//        ScrollView {
//            content
//        }
//        .scrollDisabled(!isExpanded)
//        .simultaneousGesture(
//            DragGesture(),
//            including: isExpanded ? .gesture : .subviews
//        )
//    }
//}

struct SheetScrollView<Content: View>: View {

    let position: SheetPosition
    let content: Content

    init(
        position: SheetPosition,
        @ViewBuilder content: () -> Content
    ) {
        self.position = position
        self.content = content()
    }

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                content
            }
            .frame(
                height: position.visibleHeight(
                    screenHeight: geo.size.height
                )
            )
        }
    }
}
