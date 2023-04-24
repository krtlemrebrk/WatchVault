//
//  Text.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 12.04.2023.
//

import SwiftUI

struct TextView: View {
    
    @EnvironmentObject var appManager: AppManager
    let text: String
    let font: Font
    let alignment: TextAlignment
    let lineLimit: Int?
    let shadowRadius: CGFloat
    let foreground: Colors
    let fixedForeground: Color
    let isColorFixed: Bool
    
    init(text: String, font: Font = .body, alignment: TextAlignment = .center, lineLimit: Int? = nil, shadowRadius: CGFloat = 0, foreground: Colors = .foreground) {
        self.text = text
        self.font = font
        self.alignment = alignment
        self.lineLimit = lineLimit
        self.shadowRadius = shadowRadius
        self.foreground = foreground
        self.fixedForeground = .clear
        self.isColorFixed = false
    }
    
    init(text: String, font: Font = .body, alignment: TextAlignment = .center, lineLimit: Int? = nil, shadowRadius: CGFloat = 0, fixedForeground: Color) {
        self.text = text
        self.font = font
        self.alignment = alignment
        self.lineLimit = lineLimit
        self.shadowRadius = shadowRadius
        self.foreground = .foreground
        self.fixedForeground = fixedForeground
        self.isColorFixed = true
    }
    
    var body: some View {
        HStack {
            Text(text)
                .font(font)
                .lineLimit(lineLimit)
                .multilineTextAlignment(alignment)
                .shadow(color: isColorFixed ? fixedForeground : foreground.value, radius: shadowRadius)
        }
    }
}
