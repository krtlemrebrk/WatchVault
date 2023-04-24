//
//  ContainerView.swift
//  WatchVault
//
//  Created by Kartal Emre Buruk on 8.04.2023.
//

import SwiftUI

struct ContainerView<Content: View, BackgroundContent: View>: View {
    
    @EnvironmentObject var appManager: AppManager
    let background: Colors
    let fixedBackground: Color
    let isColorFixed: Bool
    let backgroundContent: BackgroundContent
    let content: Content
    
    init(background: Colors = .background, @ViewBuilder backgroundContent: () -> BackgroundContent = {EmptyView()}, @ViewBuilder content: () -> Content) {
        self.background = background
        self.fixedBackground = .clear
        self.isColorFixed = false
        self.backgroundContent = backgroundContent()
        self.content = content()
    }
    
    init(fixedBackground: Color, @ViewBuilder backgroundContent: () -> BackgroundContent = {EmptyView()}, @ViewBuilder content: () -> Content) {
        self.background = .background
        self.fixedBackground = fixedBackground
        self.isColorFixed = true
        self.backgroundContent = backgroundContent()
        self.content = content()
    }

    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(backgroundContent)
            .background(isColorFixed ? fixedBackground : background.value)
    }
}
