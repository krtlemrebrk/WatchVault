//
//  SettingsScreen.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 19.04.2023.
//

import SwiftUI

struct SettingsScreen: View {
    
    @EnvironmentObject var appManager: AppManager
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        ContainerView {
            VStack {
                ForEach(Theme.allCases, id: \.self) { theme in
                    TextView(text: theme.name).onTapGesture {
                        AppManager.shared.changeTheme(to: theme)
                    }
                }
                Divider()
                ForEach(Language.allCases, id: \.self) { language in
                    TextView(text: language.name).onTapGesture {
                        AppManager.shared.changeLanguage(to: language)
                    }
                }
            }
        }
    }
}
