//
//  MainScreen.swift
//  WatchVault
//
//  Created by Kartal Emre Buruk on 8.04.2023.
//

import SwiftUI

struct MainScreen: View {
    
    @EnvironmentObject var appManager: AppManager
    @StateObject var tabManager = TabManager.shared

    var body: some View {
        TabView(selection: $tabManager.tabSelection) {
            ForEach(Tabs.allCases, id: \.self) { tab in
                switch tab {
                case .movie:
                    MovieScreen().tabItem { tab.tabItem }
                case .tv:
                    TVScreen().tabItem { tab.tabItem }
                case .settings:
                    SettingsScreen().tabItem { tab.tabItem }
                }
            }
            .toolbarBackground(SystemColorPalette().background, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
        .tabViewStyle(DefaultTabViewStyle())
        .tint(SystemColorPalette().primary)
        .onViewDidLoad {
            AppManager.shared.splashScreen(show: false)
        }
    }
}
