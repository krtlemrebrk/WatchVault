//
//  ConfigurationResponse.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 12.04.2023.
//

import SwiftUI

struct ConfigurationResponse: Codable {
    let images: ImageConfiguration?
}

struct ImageConfiguration: Codable {
    let baseURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case baseURL = "secure_base_url"
    }
}
