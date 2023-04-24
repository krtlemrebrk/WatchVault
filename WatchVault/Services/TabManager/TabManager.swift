//
//  TabManager.swift
//  SwiftUIDemo
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 1.04.2023.
//

import SwiftUI
import Combine


enum Tabs: Int, CaseIterable {
    case movie = 1
    case tv = 2
    case settings = 3

    var title: String {
        switch self {
        case .movie: return AppManager.shared.currentLocalization.movie
        case .tv: return AppManager.shared.currentLocalization.tv
        case .settings: return AppManager.shared.currentLocalization.settings
        }
    }
    
    var imageName: String {
        switch self {
        case .movie: return "theatermasks"
        case .tv: return "tv"
        case .settings: return "gear"
        }
    }
    
    var tabItem: some View {
        VStack {
            Image("Image/\(self.imageName)\(TabManager.shared.tabSelection == self ? ".fill" : "")")
            Text(self.title)
        }
    }
}

final class TabManager: ObservableObject {
    
    static let shared = TabManager()
    @Published var tabSelection: Tabs = .movie
    
    func changeTab(to tab: Tabs) {
        tabSelection = tab
    }
}
