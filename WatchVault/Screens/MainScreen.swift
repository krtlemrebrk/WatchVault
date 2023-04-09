//
//  MainScreen.swift
//  WatchVault
//
//  Created by Kartal Emre Buruk on 8.04.2023.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        Text("Main Screen")
    }
}





/*
 struct MainView: View {

     @StateObject var tabManager = TabManager.shared
     @StateObject var navigationManager = NavigationManager()

     var body: some View {
         NavigationStack(path: $navigationManager.navigationPath) {
             ContainerView(color: .yellow) {
                 MainTabController()
             }
             .navigationDestination(for: MainTabs.self) { tab in
                 if tab == .timeline {
                     TimelineView()
                 } else {
                     EmptyView()
                 }
             }
             .navigationDestination(for: String.self) { title in
                 DetailView(title: title)
             }
         }.environmentObject(navigationManager).tag(RootTabs.home)
     }
 }
 */

/*
 struct TimelineView: View {
     
     @StateObject var tabManager = TabManager.shared
     @EnvironmentObject var navigationManager: NavigationManager
     @State var show: Bool = false
     @State var show2: Bool = false
     @State var title: String = ""
     @State var position: CGSize = .zero
     @State var scale: CGFloat = 1

     var body: some View {
         ContainerView(color: .yellow) {
             ZStack(alignment: .bottom) {
                 VStack {
                     topBar
                     List {
                         Section("Push to navigation") {
                             listItem.listRowBackground(Color.yellow).listRowSeparator(.hidden)
                             listItem.listRowBackground(Color.yellow).listRowSeparator(.hidden)
                             listItem.listRowBackground(Color.yellow).listRowSeparator(.hidden)
                         }
                         Section("Push to view") {
                             listItem2.listRowBackground(Color.yellow).listRowSeparator(.hidden)
                             listItem2.listRowBackground(Color.yellow).listRowSeparator(.hidden)
                             listItem2.listRowBackground(Color.yellow).listRowSeparator(.hidden)
                         }

                     }.listStyle(.plain)
                     Spacer()
                 }.zIndex(1)
                 
                 if show {
                     ContainerView(color: .white) {
                         VStack {
                             HStack {
                                 Button {
                                     title = ""
                                     changeShow(to: false)
                                 } label: {
                                     Image(systemName: "chevron.left").resizable().frame(maxWidth: 15, maxHeight: 15)
                                     Text("Fuck, go back")
                                 }
                                 Spacer()
                             }.padding()
                             Spacer()
                             DetailView(title: title)
                             Spacer()
                         }
                     }.offset(position)
                         .scaleEffect(min(max(scale, 0.5), 1))
                         .transition(.move(edge: .trailing))
                         .gesture(DragGesture().onChanged({ value in
                             position = value.translation
                             scale =  1 - (value.translation.width / UIScreen.main.bounds.width)
                         }).onEnded({ value in
                             if value.translation.width > UIScreen.main.bounds.width / 3 {
                                 changeShow(to: false)
                             } else {
                                 position = .zero
                                 scale = 1
                             }
                         })).zIndex(2)
                 }

                 tabBarView.zIndex(3)

                 if show2 {
                     ContainerView(color: .white) {
                         VStack {
                             HStack {
                                 Button {
                                     title = ""
                                     changeShow(to: false)
                                 } label: {
                                     Image(systemName: "chevron.left").resizable().frame(maxWidth: 15, maxHeight: 15)
                                     Text("Fuck, go back")
                                 }
                                 Spacer()
                             }.padding()
                             Spacer()
                             DetailView(title: title)
                             Spacer()
                         }
                     }.offset(position)
                         .scaleEffect(min(max(scale, 0.5), 1))
                         .transition(.move(edge: .trailing))
                         .gesture(DragGesture().onChanged({ value in
                             guard value.translation.width > 0 else { return }
                             position = CGSize(width: value.translation.width, height: position.height)
                             // position = value.translation
                             //scale =  1 - (value.translation.width / UIScreen.main.bounds.width)
                         }).onEnded({ value in
                             if value.translation.width > UIScreen.main.bounds.width / 3 {
                                 changeShow(to: false)
                             } else {
                                 position = .zero
                                 scale = 1
                             }
                         })).zIndex(4)
                 }
             }
         }.tag(MainTabs.timeline)
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
         }.padding(.top).background(Color.orange)
     }
     
     func changeShow(to show: Bool) {
         withAnimation(.easeInOut(duration: 0.1)) {
             // self.show = show
             if show {
                 self.show = true
             } else {
                 self.position = CGSize(width: UIScreen.main.bounds.width, height: self.position.height)
                 self.scale = show2 ? 1 : 0.5
                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                     self.show = false
                     self.show2 = false
                     position = .zero
                     scale = 1
                 }
             }
         }
     }
     
     var listItem: some View {
         Button {
             //navigationManager.push("Pushed to navigation")
             title = "Pushed to view"
             show2 = true
         } label: {
             VStack {
                 Text("General Kenobi")
                 Image(systemName: "star").resizable().frame(width: 50, height: 50)
             }.padding().frame(maxWidth: .infinity).background(Color.red)
         }
     }
     
     var listItem2: some View {
         Button {
             title = "Pushed to view"
             show = true
         } label: {
             VStack {
                 Text("General Kenobi")
                 Image(systemName: "star").resizable().frame(width: 50, height: 50)
             }.padding().frame(maxWidth: .infinity).background(Color.red)
         }
     }
     
     var topBar: some View {
         HStack {
             Text("Lollipop").font(.title)
             Spacer()
             HStack(spacing: 30) {
                 Image(systemName: "heart").resizable().frame(maxWidth: 25, maxHeight: 25)
                 Image(systemName: "message").resizable().frame(maxWidth: 25, maxHeight: 25)
             }
         }.padding(.horizontal, 20)
     }
 }

 */


/*
 struct DetailView: View {
     
     @EnvironmentObject var navigationManager: NavigationManager
     let title: String
     
     var body: some View {
         ContainerView(color: .cyan) {
             Button {
                 navigationManager.push(MainTabs.timeline)
             } label: {
                 VStack {
                     Text(title)
                     Image(systemName: "star").resizable().frame(width: 50, height: 50)
                 }.padding().frame(maxWidth: .infinity)
             }
         }

         
         // NavigationLink(title, destination: { TimelineView() })
     }
 }
 */
