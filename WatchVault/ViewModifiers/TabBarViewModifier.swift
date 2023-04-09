//
//  TabBarViewModifier.swift
//  SwiftUIDemo
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 1.04.2023.
//

import SwiftUI

/*
struct TabBarViewModifier: ViewModifier {
        
    @StateObject var tabManager = TabManager.shared
    let backgroundColor: Color
    
    init(color: Color = .pink) {
        self.backgroundColor = color
    }
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            content
            Divider()
            tabBarView
        }
    }
    
    var tabBarView: some View {
        HStack {
            ForEach(tabManager.rootTabItems) { tab in
                Spacer()
                Button {
                    tabManager.changeTab(to: tab)
                } label: {
                    tab.tabBarItem
                }
                Spacer()
            }
        }.padding(.top).background(backgroundColor)
    }
}
*/
