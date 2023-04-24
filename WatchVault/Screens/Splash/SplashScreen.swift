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
        ContainerView(fixedBackground: DarkColorPalette().background) {
            VStack(spacing: 0) {
                Spacer()
                HStack(spacing: 0) {
                    Spacer()
                    ImageLiteral.appLogo.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
