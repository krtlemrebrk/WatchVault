//
//  OffsetHelper.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 13.04.2023.
//

import SwiftUI
import Combine

enum SwipeDirection {
    case up
    case down
    case none
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct OffsetHelper: ViewModifier {
    
    private var coordinateSpace: String
    @Binding private var headerOffset: CGFloat
    @Binding private var lastHeaderOffset: CGFloat
    @Binding private var shiftOffset: CGFloat
    @Binding private var headerHeight: CGFloat
    @Binding private var currentOffset: CGFloat
    @State private var direction: SwipeDirection = .none
    
    let detector = CurrentValueSubject<Bool, Never>(false)
    let publisher: AnyPublisher<Bool, Never>
    
    init(coordinateSpace: String,
         headerOffset: Binding<CGFloat>,
         lastHeaderOffset: Binding<CGFloat>,
         shiftOffset: Binding<CGFloat>,
         headerHeight: Binding<CGFloat>,
         currentOffset: Binding<CGFloat>) {
        
        self.coordinateSpace = coordinateSpace
        self._headerOffset = headerOffset
        self._lastHeaderOffset = lastHeaderOffset
        self._shiftOffset = shiftOffset
        self._headerHeight = headerHeight
        self._currentOffset = currentOffset
        
        self.publisher = detector.debounce(for: .seconds(1), scheduler: DispatchQueue.main).eraseToAnyPublisher()
    }
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: OffsetKey.self, value: proxy.frame(in: .named(coordinateSpace)).minY)
                        .onPreferenceChange(OffsetKey.self) { value in
                            if currentOffset > value {
                                currentOffset = value
                                if direction != .up && currentOffset < 0 {
                                    shiftOffset = currentOffset - headerOffset
                                    direction = .up
                                    lastHeaderOffset = headerOffset
                                }
                                let offset = currentOffset < 0 ? (currentOffset - shiftOffset) : 0
                                headerOffset = (-offset < headerHeight ? (offset < 0 ? offset : 0) : -headerHeight)
                            } else {
                                currentOffset = value
                                if direction != .down {
                                    shiftOffset = currentOffset
                                    direction = .down
                                    lastHeaderOffset = headerOffset
                                }
                                let offset = lastHeaderOffset + (currentOffset - shiftOffset)
                                headerOffset = offset > 0 ? 0 : offset
                            }
                            detector.send(true)
                        }
                        .onReceive(publisher) { update in
                            /*
                             // TODO: Run this block after touches released.
                             
                            if update {
                                direction = .none
                                if -currentOffset < headerHeight {
                                    currentOffset = 0
                                    headerOffset = 0
                                } else {
                                    headerOffset = (-headerOffset < headerHeight / 2) ? 0 : -headerHeight
                                }
                            }
                             */
                        }
                }
            }
    }
}
