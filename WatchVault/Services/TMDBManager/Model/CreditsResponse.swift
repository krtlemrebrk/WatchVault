//
//  CreditsResponse.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 20.04.2023.
//

import SwiftUI

struct CreditsResponse: Codable {
    let cast: [Cast]?
}

struct Cast: Codable, Identifiable {
    let id: Int?
    let name: String?
    let character: String?
    let profilePath: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case character
        case profilePath = "profile_path"
    }
}
