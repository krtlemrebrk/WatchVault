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
    
    var value: Color {
        switch self {
        case .background: return AppManager.shared.currentColorPalette.background
        case .foreground: return AppManager.shared.currentColorPalette.foreground
        case .primary: return AppManager.shared.currentColorPalette.primary
        }
    }
}

protocol ColorPalette {
    var background: Color { get }
    var foreground: Color { get }
    var primary: Color { get }
}

struct SystemColorPalette: ColorPalette {
    var background: Color = Color("Color/System/Background")
    var foreground: Color = Color("Color/System/Foreground")
    var primary: Color = Color("Color/System/Primary")
}

struct LightColorPalette: ColorPalette {
    var background: Color = Color("Color/Light/Background")
    var foreground: Color = Color("Color/Light/Foreground")
    var primary: Color = Color("Color/Light/Primary")
}

struct DarkColorPalette: ColorPalette {
    var background: Color = Color("Color/Dark/Background")
    var foreground: Color = Color("Color/Dark/Foreground")
    var primary: Color = Color("Color/Dark/Primary")
}
