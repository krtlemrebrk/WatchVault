//
//  GenreResponse.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 23.04.2023.
//

import SwiftUI

struct GenreResponse: Codable {
    let genres: [Genre]?
}

struct Genre: Codable, Identifiable {
    let id: Int?
    let name: String?
}
