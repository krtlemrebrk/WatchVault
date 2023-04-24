//
//  TVResponse.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 24.04.2023.
//

import SwiftUI

struct TVResponse: Codable {
    let results: [TVShow]?
}

struct TVShow: Codable, Identifiable {
    let id: Int?
    let title: String?
    let posterPath: String?
    let airDateRaw: String?
    let genres: [Genre]?
    let genresRaw: [Int]?
    let rating: Double?
    let episodeRuntime: [Int]?
    let overview: String?
    let numberOfSeasons: Int?
    let numberOfEpisodes: Int?

    var genreString: String? {
        if let genres {
            return genres.compactMap(({ $0.name })).joined(separator: ", ")
        } else if let genresRaw {
            return genresRaw.compactMap { genreId in
                return TMDBManager.shared.tvGenres.first(where: { $0.id == genreId })?.name
            }.joined(separator: ", ")
        } else {
            return nil
        }
    }
    
    var averageRuntime: Int? {
        if let episodeRuntime, !episodeRuntime.isEmpty {
            return episodeRuntime.reduce(0, +) / episodeRuntime.count
        } else {
            return nil
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title = "name"
        case posterPath = "poster_path"
        case airDateRaw = "first_air_date"
        case genres
        case genresRaw = "genre_ids"
        case rating = "vote_average"
        case episodeRuntime = "episode_run_time"
        case overview
        case numberOfSeasons = "number_of_seasons"
        case numberOfEpisodes = "number_of_episodes"
    }
}
