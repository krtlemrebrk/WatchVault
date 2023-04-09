//
//  ContainerView.swift
//  WatchVault
//
//  Created by Kartal Emre Buruk on 8.04.2023.
//

import SwiftUI

struct ContainerView<Content: View>: View {
    
    @EnvironmentObject var appManager: AppManager
    let background: Colors
    let foreground: Colors
    let content: Content
    
    init(background: Colors = .background, foreground: Colors = .foreground, @ViewBuilder content: () -> Content) {
        self.background = background
        self.foreground = foreground
        self.content = content()
    }

    var body: some View {
        content.frame(maxWidth: .infinity, maxHeight: .infinity).background(background.value).foregroundColor(foreground.value)
    }
}
