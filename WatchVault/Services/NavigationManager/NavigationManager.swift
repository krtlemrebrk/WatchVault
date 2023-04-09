//
//  NavigationManager.swift
//  SwiftUIDemo
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 1.04.2023.
//

import SwiftUI

final class NavigationManager: ObservableObject {
    
    @Published var navigationPath = NavigationPath()
    
    func push(_ item: any Hashable) {
        navigationPath.append(item)
    }
    
    func pop() {
        navigationPath.removeLast()
    }
    
    func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}
