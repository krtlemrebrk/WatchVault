//
//  AppManager.swift
//  WatchVault
//
//  Created by Kartal Emre Buruk on 8.04.2023.
//

import SwiftUI
import Combine

enum Screen {
    case welcome
    case main
}

enum Theme: String, CaseIterable {
    case system
    case light
    case dark
    
    var name: String {
        switch self {
        case .system: return AppManager.shared.currentLocalization.system
        case .light: return AppManager.shared.currentLocalization.light
        case .dark: return AppManager.shared.currentLocalization.dark
        }
    }
}

enum Language: String, CaseIterable {
    case tr
    case en
    
    var name: String {
        switch self {
        case .tr: return "Türkçe"
        case .en: return "English"
        }
    }
}

class AppManager: ObservableObject {
    
    static let shared = AppManager()
    @Published private(set) var showSplashScreen: Bool = true
    @Published private(set) var currentScreen: Screen = .welcome
    @Published private(set) var currentColorPalette: ColorPalette = SystemColorPalette()
    @Published private(set) var currentLocalization: Localization = LocalizationEN()
    private let languageChangeDetector = CurrentValueSubject<Bool, Never>(false)
    let languageChangePublisher: AnyPublisher<Bool, Never>

    @AppStorage(AppStorageKey.theme.rawValue) private var currentThemeRaw: String = Theme.system.rawValue
    var currentTheme: Theme {
        return Theme(rawValue: currentThemeRaw) ?? .system
    }
    
    @AppStorage(AppStorageKey.language.rawValue) private var currentLanguageRaw: String = Language.en.rawValue
    var currentLanguage: Language {
        return Language(rawValue: currentLanguageRaw) ?? .en
    }
    
    @AppStorage(AppStorageKey.onboardingCompleted.rawValue) private var onboardingCompleted: Bool = false

    init() {
        self.languageChangePublisher = languageChangeDetector.eraseToAnyPublisher()

        if !onboardingCompleted {
            self.onboardingCompleted = true
            self.currentLanguageRaw = self.getSystemLanguage().rawValue
        }
        self.changeLanguage(to: currentLanguage)
        self.changeTheme(to: currentTheme)
    }
    
    func changeTheme(to theme: Theme) {
        currentThemeRaw = theme.rawValue
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
        currentLanguageRaw = language.rawValue
        switch language {
        case .tr:
            currentLocalization = LocalizationTR()
        case .en:
            currentLocalization = LocalizationEN()
        }
        languageChangeDetector.send(true)
    }
    
    func splashScreen(show: Bool) {
        withAnimation {
            showSplashScreen = show
        }
    }
    
    func changeScreen(to screen: Screen) {
        withAnimation {
            currentScreen = screen
        }
    }
    
    func getPrefferedColorScheme() -> ColorScheme? {
        switch currentTheme {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
    
    private func getSystemLanguage() -> Language {
        Language(rawValue: Locale.preferredLanguages.first?.components(separatedBy: "-").first ?? Language.en.rawValue) ?? .en
    }
}
