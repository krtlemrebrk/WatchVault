//
//  Localization.swift
//  WatchVault
//
//  Created by Kartal Emre Buruk on 8.04.2023.
//

import SwiftUI

enum LocalizedKeys {
    case welcome
    
    var value: String {
        switch self {
        case .welcome: return AppManager.shared.currentLocalization.welcome
        }
    }
}

protocol Localization {
    var welcome: String { get }
}

struct LocalizationTR: Localization {
    var welcome: String = "Hoşgeldiniz"
}

struct LocalizationEN: Localization {
    var welcome: String = "Welcome"
}
