//
//  ColorPalette.swift
//  WatchVault
//
//  Created by Kartal Emre Buruk on 8.04.2023.
//

import SwiftUI

enum Colors {
    case background
    case foreground
    case primary
    case secondary
    
    var value: Color {
        switch self {
        case .background: return AppManager.shared.currentColorPalette.background
        case .foreground: return AppManager.shared.currentColorPalette.foreground
        case .primary: return AppManager.shared.currentColorPalette.primary
        case .secondary: return AppManager.shared.currentColorPalette.secondary
        }
    }
}

protocol ColorPalette {
    var background: Color { get }
    var foreground: Color { get }
    var primary: Color { get }
    var secondary: Color { get }
}

struct SystemColorPalette: ColorPalette {
    var background: Color = Color("Color/Theme/System/Background")
    var foreground: Color = Color("Color/Theme/System/Foreground")
    var primary: Color = Color("Color/Theme/System/Primary")
    var secondary: Color = Color("Color/Theme/System/Secondary")
}

struct LightColorPalette: ColorPalette {
    var background: Color = Color("Color/Theme/Light/Background")
    var foreground: Color = Color("Color/Theme/Light/Foreground")
    var primary: Color = Color("Color/Theme/Light/Primary")
    var secondary: Color = Color("Color/Theme/Light/Secondary")
}

struct DarkColorPalette: ColorPalette {
    var background: Color = Color("Color/Theme/Dark/Background")
    var foreground: Color = Color("Color/Theme/Dark/Foreground")
    var primary: Color = Color("Color/Theme/Dark/Primary")
    var secondary: Color = Color("Color/Theme/Dark/Secondary")
}

extension Color {
    static let loader: Color = Color("Color/Loader")
}

extension UIColor {
    static let appPrimary: UIColor = UIColor(named: "Color/Theme/System/Primary") ?? .tintColor
    static let appBackground: UIColor = UIColor(named: "Color/Theme/System/Background") ?? .systemBackground
    static let appForeground: UIColor = UIColor(named: "Color/Theme/System/Foreground") ?? .label
}
