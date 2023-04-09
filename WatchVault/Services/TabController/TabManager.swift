//
//  TabManager.swift
//  SwiftUIDemo
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 1.04.2023.
//

import SwiftUI
import Combine

/*
enum RootTabs: Int, CaseIterable {
    case home = 1
    case favorites = 2
    case profile = 3

    var title: String {
        switch self {
        case .home: return "Home"
        case .favorites: return "Favorites"
        case .profile: return "Profile"
        }
    }
    
    var imageName: String {
        switch self {
        case .home: return "house"
        case .favorites: return "star"
        case .profile: return "person"
        }
    }
}

enum MainTabs: Int, CaseIterable {
    case post = 1
    case timeline = 2
    case messages = 3
}

final class TabManager: ObservableObject {

    static let shared = TabManager()

    @Published var rootTabSelection: RootTabs = .home
    @Published private(set) var rootTabItems: [RootTab] = []

    @Published var mainTabSelection: MainTabs = .timeline
    @Published private(set) var mainTabItems: [MainTab] = []

    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.rootTabItems = RootTabs.allCases.map{ RootTab($0, selected: $0 == self.rootTabSelection) }
        self.mainTabItems = MainTabs.allCases.map{ MainTab($0, selected: $0 == self.mainTabSelection) }
        self.subscribeToSelections()
    }
    
    func changeTab(to nextTab: RootTab) {
        rootTabSelection = nextTab.tab
    }
    
    func changeTab(to nextTab: MainTab) {
        mainTabSelection = nextTab.tab
    }

    private func subscribeToSelections() {
        $rootTabSelection.sink { selectedTab in
            self.updateRootTabItems(selectedTab: selectedTab)
        }.store(in: &cancellables)
        
        $mainTabSelection.sink { selectedTab in
            self.updateMainTabItems(selectedTab: selectedTab)
        }.store(in: &cancellables)
    }
    
    private func updateRootTabItems(selectedTab: RootTabs) {
        rootTabItems = rootTabItems.map { tabItem in
            return RootTab(tabItem.tab, selected: tabItem.tab == selectedTab)
        }
    }
    
    private func updateMainTabItems(selectedTab: MainTabs) {
        mainTabItems = mainTabItems.map { tabItem in
            return MainTab(tabItem.tab, selected: tabItem.tab == selectedTab)
        }
    }
}
*/
