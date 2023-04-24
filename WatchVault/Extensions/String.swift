//
//  String.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 23.04.2023.
//

import SwiftUI

extension String {
    func releaseYear() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else { return nil }
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
        guard let year = calendarDate.year else { return nil }
        return String(year)
    }
}
