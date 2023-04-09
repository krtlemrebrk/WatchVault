//
//  TabController.swift
//  SwiftUIDemo
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 1.04.2023.
//

import SwiftUI

/*
struct RootTabController: View {
    
    @StateObject var tabManager = TabManager.shared

    var body: some View {
        TabView(selection: $tabManager.rootTabSelection) {
            ForEach(tabManager.rootTabItems) { rootTab in
                switch rootTab.tab {
                case .home:
                    MainView()
                case .favorites:
                    ContainerView(color: .purple) {
                        Text("Favorites").font(.title)
                    }.tabBar().tag(RootTabs.favorites)
                case .profile:
                    ContainerView(color: .green) {
                        Text("Profile").font(.title)
                    }.tabBar().tag(RootTabs.profile)
                }
            }
        }.tabViewStyle(DefaultTabViewStyle())
    }
}

struct MainTabController: View {
    
    @StateObject var tabManager = TabManager.shared

    var body: some View {
        TabView(selection: $tabManager.mainTabSelection) {
            ForEach(tabManager.mainTabItems) { mainTab in
                switch mainTab.tab {
                case .post:
                    ContainerView(color: .green) {
                        Text("post")
                    }.tag(MainTabs.post)
                case .timeline:
                    TimelineView()
                case .messages:
                    ContainerView(color: .mint) {
                        Text("messages")
                    }.tag(MainTabs.messages)
                }
            }
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)).ignoresSafeArea()
    }
}
*/
