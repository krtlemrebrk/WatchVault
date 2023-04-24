//
//  View.swift
//  SwiftUIDemo
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 1.04.2023.
//

import SwiftUI

typealias Parameters = [String: String]
typealias VoidHandler = (() -> Void)

extension View {
    
    func onViewDidLoad(perform action: VoidHandler? = nil) -> some View {
        modifier(ViewDidLoadModifier(action: action))
    }
}
