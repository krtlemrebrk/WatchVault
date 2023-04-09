//
//  WatchVaultApp.swift
//  WatchVault
//
//  Created by Kartal Emre Buruk on 9.04.2023.
//

import SwiftUI

@main
struct WatchVaultApp: App {
    
    init() {
        UITabBar.appearance().isHidden = true
        // UIScrollView.appearance().bounces = false
    }
    
    var body: some Scene {
        WindowGroup {
            AppCoordinator().environmentObject(AppManager.shared)
        }
    }
}

struct WatchVaultApp_Previews: PreviewProvider {

    static var previews: some View {
        AppCoordinator().environmentObject(AppManager.shared)
    }
}
