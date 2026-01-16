//
//  NotificationView.swift
//  Waitless
//
//  Created by shayan khatibshad on 2026-01-16.
//

import SwiftUI

struct NotificationView: View {
    
    @ObservedObject var vm = NotificationViewModel()
    @EnvironmentObject var coordinator: MainCoordinator
    
    var body: some View {
        if vm.notifications.isEmpty {
            EmptyStateView(icon: "ic-empty-notification", title: "No Notifications", caption: "Notification Inbox Is Empty")
        } else {
            ScrollView {
                LazyVStack {
//                    ForEach(vm.notifications, id: \.self) { notification in
//                        HStack {
//                            Text(notification.title)
//                            Spacer()
//                            Text(notification.date, style: .date)
//                        }
//                        .padding()
//                        .onTapGesture {
//                            vm.select(notification: notification)
//                        }
//                    }
                }
            }
        }
    }
}

#Preview {
    NotificationView()
        .environmentObject(MainCoordinator())
}
