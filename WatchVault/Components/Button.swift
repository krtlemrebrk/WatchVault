//
//  Button.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 12.04.2023.
//

import SwiftUI

enum ButtonType {
    case text
    case filled
    case outline
}

struct ButtonView: View {
    
    @EnvironmentObject var appManager: AppManager
    let buttonType: ButtonType
    let title: String
    let font: Font
    let fontWeight: Font.Weight
    let cornerRadius: CGFloat
    let shadowRadius: CGFloat
    let background: Colors
    let fixedBackground: Color
    let foreground: Colors
    let fixedForeground: Color
    let isColorsFixed: Bool
    let action: VoidHandler
    
    init(buttonType: ButtonType = .filled, title: String, font: Font = .body, fontWeight: Font.Weight = .bold, cornerRadius: CGFloat = 20, shadowRadius: CGFloat = 0, background: Colors = .primary, foreground: Colors = .foreground, action: @escaping VoidHandler) {
        self.buttonType = buttonType
        self.title = title
        self.font = font
        self.fontWeight = fontWeight
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.background = background
        self.fixedBackground = .clear
        self.foreground = foreground
        self.fixedForeground = .clear
        self.isColorsFixed = false
        self.action = action
    }
    
    init(buttonType: ButtonType = .filled, title: String, font: Font = .body, fontWeight: Font.Weight = .bold, cornerRadius: CGFloat = 20, shadowRadius: CGFloat = 0, fixedBackground: Color, fixedForeground: Color, action: @escaping VoidHandler) {
        self.buttonType = buttonType
        self.title = title
        self.font = font
        self.fontWeight = fontWeight
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.background = .background
        self.fixedBackground = fixedBackground
        self.foreground = .foreground
        self.fixedForeground = fixedForeground
        self.isColorsFixed = true
        self.action = action
    }

    @ViewBuilder
    var body: some View {
        Button {
            action()
        } label: {
            switch buttonType {
            case .text:
                Text(title)
                    .font(font)
                    .fontWeight(fontWeight)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(isColorsFixed ? fixedForeground : foreground.value)
                    .shadow(color: isColorsFixed ? fixedForeground : foreground.value, radius: shadowRadius)
            case .filled:
                Text(title)
                    .font(font)
                    .fontWeight(fontWeight)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isColorsFixed ? fixedBackground : background.value)
                    .foregroundColor(isColorsFixed ? fixedForeground : foreground.value)
                    .cornerRadius(cornerRadius)
                    .shadow(color: isColorsFixed ? fixedForeground : foreground.value, radius: shadowRadius)
            case .outline:
                Text(title)
                    .font(font)
                    .fontWeight(fontWeight)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(isColorsFixed ? fixedForeground : foreground.value)
                    .cornerRadius(cornerRadius)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(appManager.currentColorPalette.primary, lineWidth: 2))
                    .shadow(color: isColorsFixed ? fixedForeground : foreground.value, radius: shadowRadius)
            }
        }
    }
}
