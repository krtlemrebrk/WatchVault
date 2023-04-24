//
//  TabCollectionView.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 24.04.2023.
//

import SwiftUI

struct TabCollectionView<Content: View>: View {
    let title: String
    let titleFont: Font
    let titleAlignment: TextAlignment
    let frameLimit: CGFloat
    let indexDisplayMode: PageTabViewStyle.IndexDisplayMode
    let content: Content
    
    init(title: String,
         titleFont: Font = .title,
         titleAlignment: TextAlignment = .center,
         frameLimit: CGFloat,
         indexDisplayMode: PageTabViewStyle.IndexDisplayMode = .never,
         @ViewBuilder content: () -> Content) {
        
        self.title = title
        self.titleFont = titleFont
        self.titleAlignment = titleAlignment
        self.frameLimit = frameLimit
        self.indexDisplayMode = indexDisplayMode
        self.content = content()
    }
    
    var body: some View {
        Section {
            headerView.padding(.horizontal)
            bodyView
        }
    }
    
    @ViewBuilder
    var headerView: some View {
        switch titleAlignment {
        case .leading:
            HStack {
                TextView(text: title, font: titleFont)
                Spacer()
            }
        case .center:
            TextView(text: title, font: titleFont)
        case .trailing:
            HStack {
                Spacer()
                TextView(text: title, font: titleFont)
            }
        }
    }

    @ViewBuilder
    var bodyView: some View {
        TabView {
            content
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: indexDisplayMode)).frame(height: frameLimit)
    }
}
