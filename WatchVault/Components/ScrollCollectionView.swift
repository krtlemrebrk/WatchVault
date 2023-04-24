//
//  ScrollCollectionView.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 24.04.2023.
//

import SwiftUI

struct ScrollCollectionView<Content: View>: View {
    
    let title: String
    let titleFont: Font
    let titleAlignment: TextAlignment
    let axis: Axis.Set
    let gridItems: [GridItem]
    let frameLimit: CGFloat
    let spacing: CGFloat
    let showsIndicators: Bool
    let content: Content
    
    init(axis: Axis.Set,
         title: String,
         titleFont: Font = .title2,
         titleAlignment: TextAlignment = .leading,
         gridItemCount: Int = 1,
         frameLimit: CGFloat,
         spacing: CGFloat = 15,
         showsIndicators: Bool = false,
         @ViewBuilder content: () -> Content) {
        
        self.axis = axis
        self.title = title
        self.titleFont = titleFont
        self.titleAlignment = titleAlignment
        self.gridItems = [GridItem](repeating: GridItem(), count: gridItemCount)
        self.frameLimit = frameLimit
        self.spacing = spacing
        self.showsIndicators = showsIndicators
        self.content = content()
    }
    
    var body: some View {
        Section {
            headerView.padding(.horizontal)
            scrollView
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
    var scrollView: some View {
        switch axis {
        case .horizontal:
            ScrollView(.horizontal, showsIndicators: showsIndicators) {
                LazyHGrid(rows: gridItems, alignment: .center, spacing: spacing) {
                    content
                }.frame(height: frameLimit).padding(.horizontal)
            }
        case .vertical:
            ScrollView(.vertical, showsIndicators: showsIndicators) {
                LazyVGrid(columns: gridItems, alignment: .center, spacing: spacing) {
                    content
                }.frame(width: frameLimit).padding(.horizontal)
            }
        default:
            EmptyView()
        }
    }
}
