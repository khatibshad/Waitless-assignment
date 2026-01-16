//
//  EmptyView.swift
//  Waitless
//
//  Created by shayan khatibshad on 2026-01-16.
//

import SwiftUI

struct EmptyStateView: View {
    
    let icon: String
    let title: String
    let caption: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(icon)
            WATextView(text: title, style: .custom(style: .init(font: .system(size: 26, weight: .bold), normalColor: .textBlack, selectedColor: .textBlack, disabledColor: .textBlack)), textColor: .textBlack)
            WATextView(text: caption, style: .caption, textColor: .textSecondary)
        }
        .background(Color.clear)
        .padding()
    }
}


#Preview {
    EmptyStateView(icon: "ic-empty-notification", title: "No Notifications", caption: "Notification Inbox Is Empty")
}
