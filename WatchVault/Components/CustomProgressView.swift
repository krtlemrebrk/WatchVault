//
//  CustomProgressView.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 16.04.2023.
//

import SwiftUI

struct CustomProgressView: View {
    
    @Binding private var isAnimating: Bool
    @Binding private var currentOffset: CGFloat
    private let refreshOffset: CGFloat
    private let refreshAction: VoidHandler?
    
    init(isAnimating: Binding<Bool>, currentOffset: Binding<CGFloat>, refreshOffset: CGFloat, refreshAction: VoidHandler? = nil) {
        self._isAnimating = isAnimating
        self._currentOffset = currentOffset
        self.refreshOffset = refreshOffset
        self.refreshAction = refreshAction
    }
    
    var body: some View {
        ProgressView(value: value(), total: 1.0)
            .progressViewStyle(CustomLoaderStyle(isAnimating: $isAnimating, refreshAction: refreshAction))
            .frame(width: 30, height: 30)
            .opacity(isAnimating ? 1.0 : (currentOffset < 0 ? 0 : (currentOffset > refreshOffset ? 1.0 : currentOffset / refreshOffset)))
    }
    
    private func value() -> Double {
        guard !isAnimating && currentOffset < refreshOffset else { return 1.0 }
        guard currentOffset >= 0 else { return 0 }
        if currentOffset / refreshOffset < 0.5 {
            return (currentOffset / refreshOffset) * 0.5
        } else if currentOffset / refreshOffset < 0.75 {
            return (currentOffset / refreshOffset) * 0.75
        } else {
            return currentOffset / refreshOffset
        }
    }
}

struct CustomLoaderStyle: ProgressViewStyle {
    @Binding private var isAnimating: Bool
    private var refreshAction: VoidHandler?
    
    init(isAnimating: Binding<Bool>, refreshAction: VoidHandler? = nil) {
        self._isAnimating = isAnimating
        self.refreshAction = refreshAction
    }

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        if configuration.fractionCompleted == 1 {
            LottieView(lottieFile: "Loader")
            .onAppear {
                self.isAnimating = true
                self.refreshAction?()
            }
        } else {
            Circle()
            .trim(from: 0, to: fractionCompleted)
            .stroke(Color.loader, style: StrokeStyle(lineWidth: 3.0, lineCap: .round))
            .rotationEffect(.degrees(270))
            .padding(5)
            .animation(Animation.easeOut(duration: 1).repeatForever(autoreverses: false), value: configuration.fractionCompleted)
        }
    }
}
