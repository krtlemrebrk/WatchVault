//
//  TMDBManager.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 12.04.2023.
//

import SwiftUI

class TMDBManager: ObservableObject {
    
    static let shared = TMDBManager()
    static let TMDB_API_BASE_URL = "https://api.themoviedb.org/3"
    private let TMDB_API_KEY = "YOUR-API-KEY" // TODO: Change this with real TMDB API Key.
    private(set) var TMDB_API_IMAGE_BASE_URL = ""
    private(set) var movieGenres: [Genre] = [Genre]()
    private(set) var tvGenres: [Genre] = [Genre]()
    
    func getDefaultParameters(includeLanguage: Bool = true) -> Parameters {
        var params = Parameters()
        params["api_key"] = TMDB_API_KEY
        if includeLanguage {
            params["language"] = "\(AppManager.shared.currentLanguage.rawValue)-\(AppManager.shared.currentLanguage.rawValue.localizedUppercase)"
        }
        return params
    }
    
    func getConfiguration() async {
        guard let response = await TMDB.configuration().request(ConfigurationResponse.self), let url = response.images?.baseURL
        else {
            return
        }
        
        self.TMDB_API_IMAGE_BASE_URL = url
    }

    func getMovieGenres() async {
        guard let response = await TMDB.Movie.genre().request(GenreResponse.self)
        else {
            return
        }
        
        self.movieGenres = response.genres ?? []
    }
    
    func getTVGenres() async {
        guard let response = await TMDB.TV.genre().request(GenreResponse.self)
        else {
            return
        }
        
        self.tvGenres = response.genres ?? []
    }
    
    func getTrending() async -> [Image] {
        guard let response = await TMDB.trending().request(TrendingResponse.self)
        else {
            return []
        }
        
        if let results = response.results?.compactMap({ $0.posterPath }).prefix(20) {
            return await getImages(Array(results))
        } else {
            return []
        }
    }
    
    func getPopularMovies() async -> [Movie] {
        guard let response = await TMDB.Movie.popular().request(MovieResponse.self)
        else {
            return []
        }
        
        if let results = response.results?.compactMap({ $0 }).prefix(20) {
            return Array(results)
        } else {
            return []
        }
    }
    
    func getPopularTVShows() async -> [TVShow] {
        guard let response = await TMDB.TV.popular().request(TVResponse.self)
        else {
            return []
        }
        
        if let results = response.results?.compactMap({ $0 }).prefix(20) {
            return Array(results)
        } else {
            return []
        }
    }
    
    func getUpcomingMovies() async -> [Movie] {
        guard let response = await TMDB.Movie.upcoming().request(MovieResponse.self)
        else {
            return []
        }
        
        if let results = response.results?.compactMap({ $0 }).prefix(20) {
            return Array(results)
        } else {
            return []
        }
    }
    
    func getOnAirTVShows() async -> [TVShow] {
        guard let response = await TMDB.TV.onAir().request(TVResponse.self)
        else {
            return []
        }
        
        if let results = response.results?.compactMap({ $0 }).prefix(20) {
            return Array(results)
        } else {
            return []
        }
    }
    
    func getTopRatedMovies() async -> [Movie] {
        guard let response = await TMDB.Movie.topRated().request(MovieResponse.self)
        else {
            return []
        }
        
        if let results = response.results?.compactMap({ $0 }).prefix(20) {
            return Array(results)
        } else {
            return []
        }
    }
    
    func getTopRatedTVShows() async -> [TVShow] {
        guard let response = await TMDB.TV.topRated().request(TVResponse.self)
        else {
            return []
        }
        
        if let results = response.results?.compactMap({ $0 }).prefix(20) {
            return Array(results)
        } else {
            return []
        }
    }
    
    func getMovieDetail(_ movieId: Int) async -> Movie? {
        guard let response = await TMDB.Movie.detail(movieId).request(Movie.self)
        else {
            return nil
        }
        return response
    }
    
    func getTVShowDetail(_ tvId: Int) async -> TVShow? {
        guard let response = await TMDB.TV.detail(tvId).request(TVShow.self)
        else {
            return nil
        }
        return response
    }
    
    func getMovieCredits(_ movieId: Int) async -> [Cast] {
        guard let response = await TMDB.Movie.credits(movieId).request(CreditsResponse.self)
        else {
            return []
        }
        return response.cast ?? []
    }
    
    func getTVCredits(_ tvId: Int) async -> [Cast] {
        guard let response = await TMDB.TV.credits(tvId).request(CreditsResponse.self)
        else {
            return []
        }
        return response.cast ?? []
    }

    func downloadImage(from path: String) async -> Image? {
        guard let cachedImage = CacheManager.shared.get(name: path) else {
            guard let savedImage = LocalFileManager.shared.get(name: path) else {
                guard let uiImage = await TMDB.image(path).imageRequest()
                else {
                    return nil
                }
                CacheManager.shared.add(image: uiImage, name: path)
                LocalFileManager.shared.add(image: uiImage, name: path)
                return Image(uiImage: uiImage)
            }
            CacheManager.shared.add(image: savedImage, name: path)
            return Image(uiImage: savedImage)
        }
        return Image(uiImage: cachedImage)
    }
    
    private func getImages(_ imageURLs: [String]) async -> [Image] {
        let images = await withTaskGroup(of: Image?.self) { group in
            for url in imageURLs {
                group.addTask {
                    await self.downloadImage(from: url)
                }
            }
            
            var images = [Image?]()
            for await image in group {
                images.append(image)
            }
            return images.compactMap({ $0 })
        }
        return images
    }
}
