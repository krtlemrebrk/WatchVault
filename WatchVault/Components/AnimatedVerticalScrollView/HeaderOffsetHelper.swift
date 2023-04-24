//
//  HeaderOffsetHelper.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 13.04.2023.
//

import SwiftUI

struct HeaderBondsKey: PreferenceKey {
    static var defaultValue: Anchor<CGRect>?
    static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
        value = nextValue()
    }
}

struct HeaderOffsetHelper: ViewModifier {
    
    private let header: AnyView
    @Binding private var headerHeight: CGFloat
    @Binding private var headerOffset: CGFloat
    @State private var show: Bool = false
    
    init(header: AnyView, headerHeight: Binding<CGFloat>, headerOffset: Binding<CGFloat>) {
        self.header = header
        self._headerHeight = headerHeight
        self._headerOffset = headerOffset
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                if show {
                    header
                        .offset(y: -headerOffset < headerHeight ? headerOffset : (headerOffset < 0 ? headerOffset : 0))
                        .anchorPreference(key: HeaderBondsKey.self, value: .bounds) { $0 }
                        .overlayPreferenceValue(HeaderBondsKey.self) { value in
                            GeometryReader { proxy in
                                if let anchor = value {
                                    Color.clear.onAppear {
                                        headerHeight = proxy[anchor].height
                                        
                                        UIRefreshControl.appearance().bounds = CGRect(x: UIRefreshControl.appearance().bounds.origin.x,
                                                                                      y: UIRefreshControl.appearance().bounds.origin.y - headerHeight,
                                                                                      width: UIRefreshControl.appearance().bounds.size.width,
                                                                                      height: UIRefreshControl.appearance().bounds.size.height)
                                    }
                                }
                            }
                        }
                }
            }.onAppear {
                show = true
            }
    }
}
