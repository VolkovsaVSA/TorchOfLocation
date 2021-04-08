//
//  TorchOfLocationApp.swift
//  TorchOfLocation
//
//  Created by Sergey Volkov on 22.02.2021.
//

import SwiftUI

@main
struct TorchOfLocationApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(LocationManager(latitude: 0, longitude: 0))
        }
    }
}
