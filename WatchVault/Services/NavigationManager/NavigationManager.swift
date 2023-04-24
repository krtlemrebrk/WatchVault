//
//  NavigationManager.swift
//  SwiftUIDemo
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 1.04.2023.
//

import SwiftUI


enum ScreenCode: Hashable {

    case movieDetail(Int)
    case tvDetail(Int)
    
    var rawValue: Int {
        switch self {
        case .movieDetail(_): return 1
        case .tvDetail(_): return 2
        }
    }
    
    var screen: AnyView {
        switch self {
        case .movieDetail(let movieId):
            return AnyView(MovieDetailScreen(movieId: movieId))
        case .tvDetail(let tvId):
            return AnyView(TVDetailScreen(tvId: tvId))
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
    
    static func == (lhs: ScreenCode, rhs: ScreenCode) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}
 

final class NavigationManager: ObservableObject {
    
    @Published var navigationPath = NavigationPath()
    
    func push(_ item: any Hashable) {
        navigationPath.append(item)
    }
    
    func push(_ screenCode: ScreenCode) {
        navigationPath.append(screenCode)
    }
    
    func pop() {
        navigationPath.removeLast()
    }
    
    func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}

struct NavigationController<Content: View>: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $navigationManager.navigationPath) {
            content
            .navigationDestination(for: ScreenCode.self) { screenCode in
                screenCode.screen
            }
        }
    }
}
