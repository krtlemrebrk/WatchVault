//
//  SplashScreen.swift
//  WatchVault
//
//  Created by Kartal Emre Buruk on 8.04.2023.
//

import SwiftUI

struct SplashScreen: View {
        
    @EnvironmentObject var appManager: AppManager
    
    var body: some View {
        ContainerView {
            VStack {
                Text(LocalizedKeys.welcome.value)
                Divider()
                Text("Dark").onTapGesture {
                    AppManager.shared.changeTheme(to: .dark)
                }
                Text("Light").onTapGesture {
                    AppManager.shared.changeTheme(to: .light)
                }
                Text("System").onTapGesture {
                    AppManager.shared.changeTheme(to: .system)
                }
                Divider()
                Text("EN").onTapGesture {
                    AppManager.shared.changeLanguage(to: .en)
                }
                Text("TR").onTapGesture {
                    AppManager.shared.changeLanguage(to: .tr)
                }
            }
        }
    }
}
