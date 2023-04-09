//
//  TabBarItem.swift
//  SwiftUIDemo
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 1.04.2023.
//

import SwiftUI

/*
struct RootTab: Identifiable {
    let id: Int
    let tab: RootTabs
    var selected: Bool
    
    init(_ tab: RootTabs, selected: Bool = false) {
        self.id = tab.rawValue
        self.tab = tab
        self.selected = selected
    }
    
    var tabBarItem: some View {
        VStack {
            Image(systemName: selected ? "\(tab.imageName).fill" : tab.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .foregroundColor(selected ? .red : .gray)
            
            Text(tab.title)
                .font(.caption2)
                .foregroundColor(selected ? .red : .gray)
        }
    }
}

struct MainTab: Identifiable {
    let id: Int
    let tab: MainTabs
    var selected: Bool
    
    init(_ tab: MainTabs, selected: Bool = false) {
        self.id = tab.rawValue
        self.tab = tab
        self.selected = selected
    }
}
*/
