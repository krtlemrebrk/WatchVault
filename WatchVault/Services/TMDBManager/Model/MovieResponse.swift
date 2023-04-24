//
//  MovieResponse.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 18.04.2023.
//

import SwiftUI

struct MovieResponse: Codable {
    let results: [Movie]?
}

struct Movie: Codable, Identifiable {
    let id: Int?
    let title: String?
    let posterPath: String?
    let releaseDateRaw: String?
    let genres: [Genre]?
    let genresRaw: [Int]?
    let rating: Double?
    let runtime: Int?
    let overview: String?
    
    var genreString: String? {
        if let genres {
            return genres.compactMap(({ $0.name })).joined(separator: ", ")
        } else if let genresRaw {
            return genresRaw.compactMap { genreId in
                return TMDBManager.shared.movieGenres.first(where: { $0.id == genreId })?.name
            }.joined(separator: ", ")
        } else {
            return nil
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case releaseDateRaw = "release_date"
        case genres
        case genresRaw = "genre_ids"
        case rating = "vote_average"
        case runtime
        case overview
    }
}
