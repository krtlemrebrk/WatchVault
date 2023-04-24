//
//  WatchVaultApp.swift
//  WatchVault
//
//  Created by Kartal Emre Buruk on 9.04.2023.
//

import SwiftUI

@main
struct WatchVaultApp: App {
    
    @Namespace var namespace
    
    init() {
        let coloredNavigationBarAppearance = UINavigationBarAppearance()
        coloredNavigationBarAppearance.configureWithTransparentBackground()
        coloredNavigationBarAppearance.backgroundColor = UIColor.appBackground
        coloredNavigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.appForeground]
        coloredNavigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.appForeground]

        UINavigationBar.appearance().standardAppearance = coloredNavigationBarAppearance
        UINavigationBar.appearance().compactAppearance = coloredNavigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavigationBarAppearance
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
