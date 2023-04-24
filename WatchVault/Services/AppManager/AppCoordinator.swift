//
//  AppCoordinator.swift
//  WatchVault
//
//  Created by Kartal Emre Buruk on 8.04.2023.
//

import SwiftUI

struct AppCoordinator: View {
    
    @EnvironmentObject var appManager: AppManager

    var body: some View {
        ZStack {
            switch appManager.currentScreen {
            case .main: MainScreen()
            case .welcome: WelcomeScreen()
            }
            SplashScreen().opacity(appManager.showSplashScreen ? 1 : 0)
        }
        .onViewDidLoad {
            Task {
                await TMDBManager.shared.getConfiguration()
            }
        }.preferredColorScheme(AppManager.shared.getPrefferedColorScheme())
    }
}
