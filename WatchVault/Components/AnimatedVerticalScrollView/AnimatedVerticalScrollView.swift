//
//  AnimatedHeaderScrollView.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 13.04.2023.
//

import SwiftUI

struct AnimatedVerticalScrollView<HeaderContent: View, Content: View>: View {

    private let headerContent: HeaderContent
    private let content: Content
    private var coordinateSpace = UUID().uuidString
    private let refreshAction: VoidHandler?
    private let refreshOffset: CGFloat = 60
    @Binding var isAnimating: Bool
    @Binding private var headerHeight: CGFloat
    @Binding private var headerOffset: CGFloat
    @State private var currentOffset: CGFloat = 0
    @State private var lastHeaderOffset: CGFloat = 0
    @State private var shiftOffset: CGFloat = 0
    
    init(isAnimating: Binding<Bool>, headerHeight: Binding<CGFloat>, headerOffset: Binding<CGFloat>, @ViewBuilder headerContent: () -> HeaderContent, @ViewBuilder content: () -> Content, refreshAction: VoidHandler? = nil) {
        self._isAnimating = isAnimating
        self._headerHeight = headerHeight
        self._headerOffset = headerOffset
        self.headerContent = headerContent()
        self.content = content()
        self.refreshAction = refreshAction
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            if refreshAction != nil {
                CustomProgressView(isAnimating: $isAnimating, currentOffset: $currentOffset, refreshOffset: refreshOffset, refreshAction: refreshAction)
                    .padding(.top, headerHeight + 10)
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                content
                    .padding(.top, isAnimating ? (currentOffset > 0 ? (headerHeight + refreshOffset - currentOffset) : headerHeight + refreshOffset) : headerHeight)
                    .modifier(OffsetHelper(coordinateSpace: coordinateSpace,
                                           headerOffset: $headerOffset,
                                           lastHeaderOffset: $lastHeaderOffset,
                                           shiftOffset: $shiftOffset,
                                           headerHeight: $headerHeight,
                                           currentOffset: $currentOffset))
            }
            .coordinateSpace(name: coordinateSpace)
            .modifier(HeaderOffsetHelper(header: AnyView(headerContent), headerHeight: $headerHeight, headerOffset: $headerOffset))
        }
    }
}

/*
 // TODO: Scroll touch release detector?
 
 extension UIApplication {
     func addScrollReleaseRecognizer() {
         guard let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first else { return }
         let tapGesture = UIPanGestureRecognizer(target: self, action: #selector(tapAction))
         tapGesture.requiresExclusiveTouchType = false
         tapGesture.cancelsTouchesInView = false
         tapGesture.delegate = self
         window.addGestureRecognizer(tapGesture)
     }
     
     @objc func tapAction(_ sender: UIPanGestureRecognizer) {
         print(sender.numberOfTouches)
     }
 }
 
 extension UIApplication: UIGestureRecognizerDelegate {
     public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
         return true
     }
 }
 */
