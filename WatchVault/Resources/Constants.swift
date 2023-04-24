//
//  Constants.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 11.04.2023.
//

import SwiftUI

enum AppStorageKey: String {
    case theme
    case language
    case onboardingCompleted
}

enum ImageLiteral: String {
    case appLogo = "Image/appLogo"
    case back = "Image/back"
    case cover = "Image/cover"
    case envelope = "Image/envelope"
    case lock = "Image/lock"
    case eye = "Image/eye.fill"
    case eyeSlash = "Image/eye.slash.fill"
    case star = "Image/star"
    case person = "Image/person"
    
    var image: Image {
        return Image(self.rawValue)
    }
}
