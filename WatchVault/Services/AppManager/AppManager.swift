//
//  AppManager.swift
//  WatchVault
//
//  Created by Kartal Emre Buruk on 8.04.2023.
//

import SwiftUI

enum Screen {
    case welcome
    case main
}

enum Theme: String {
    case system
    case light
    case dark
}

enum Language: String {
    case tr
    case en
}

class AppManager: ObservableObject {
    
    static let shared = AppManager()
    
    @Published private(set) var showSplashScreen: Bool = true
    @Published private(set) var currentScreen: Screen = .welcome
    @Published private(set) var currentColorPalette: ColorPalette = SystemColorPalette()
    @Published private(set) var currentLocalization: Localization = LocalizationEN()
    @AppStorage("theme") var currentTheme: String = Theme.system.rawValue
    @AppStorage("language") var currentLanguage: String = Language.en.rawValue
    @AppStorage("onboardingCompleted") var onboardingCompleted: Bool = false

    init() {
        if !onboardingCompleted {
            self.onboardingCompleted = true
            self.changeLanguage(to: self.getSystemLanguage())
        }
        self.changeTheme(to: Theme(rawValue: self.currentTheme) ?? .system)
    }
    
    func changeTheme(to theme: Theme) {
        currentTheme = theme.rawValue
        switch theme {
        case .system:
            currentColorPalette = SystemColorPalette()
        case .light:
            currentColorPalette = LightColorPalette()
        case .dark:
            currentColorPalette = DarkColorPalette()
        }
    }
    
    func changeLanguage(to language: Language) {
        currentLanguage = language.rawValue
        switch language {
        case .tr:
            currentLocalization = LocalizationTR()
        case .en:
            currentLocalization = LocalizationEN()
        }
    }
    
    private func getSystemLanguage() -> Language {
        Language(rawValue: Locale.preferredLanguages.first?.components(separatedBy: "-").first ?? Language.en.rawValue) ?? .en
    }
}
