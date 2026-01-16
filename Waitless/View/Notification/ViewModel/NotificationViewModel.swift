//
//  NotificationViewModel.swift
//  Waitless
//
//  Created by shayan khatibshad on 2026-01-16.
//

import SwiftUI

class NotificationViewModel: ObservableObject {
    @Published var notifications = [DummyModel]()
    
}
