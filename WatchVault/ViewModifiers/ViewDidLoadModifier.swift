//
//  ViewDidLoadModifier.swift
//  SwiftUIDemo
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 1.04.2023.
//

import SwiftUI

struct ViewDidLoadModifier: ViewModifier {
    
    @State private var viewDidLoad = false
    let action: VoidHandler?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if !viewDidLoad {
                    viewDidLoad = true
                    action?()
                }
            }
    }
}
