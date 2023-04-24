//
//  LottieView.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 16.04.2023.
//

import SwiftUI
import Lottie
 
struct LottieView: UIViewRepresentable {
    
    let lottieFile: String
    let loopMode: LottieLoopMode
    private var animationView = LottieAnimationView()
    
    init(lottieFile: String, loopMode: LottieLoopMode = .loop) {
        self.lottieFile = lottieFile
        self.loopMode = loopMode
    }
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView()
        animationView.animation = LottieAnimation.named(lottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([animationView.widthAnchor.constraint(equalTo: view.widthAnchor), animationView.heightAnchor.constraint(equalTo: view.heightAnchor)])
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        animationView.play()
    }
}
