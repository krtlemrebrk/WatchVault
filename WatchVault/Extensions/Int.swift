//
//  Int.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 23.04.2023.
//

import SwiftUI

extension Int {
    func minuteToHours() -> String {
        if self < 60 {
            return String(format: "%d%@", self, AppManager.shared.currentLocalization.minuteShort)
        } else {
            return String(format: "%d%@ %d%@", (self/60), AppManager.shared.currentLocalization.hourShort, (self % 60), AppManager.shared.currentLocalization.minuteShort)
        }
    }
    
    func seasons() -> String {
        return String(format: "%d %@", self, AppManager.shared.currentLocalization.season)
    }
    
    func episodes() -> String {
        return String(format: "%d %@", self, AppManager.shared.currentLocalization.episode)
    }
}
