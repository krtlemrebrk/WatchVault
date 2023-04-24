//
//  TrendingResponse.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 12.04.2023.
//

import SwiftUI

struct TrendingResponse: Codable {
    let results: [TrendingContent]?
}

struct TrendingContent: Codable {
    let title: String?
    let posterPath: String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
    }
}
