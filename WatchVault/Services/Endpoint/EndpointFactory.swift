//
//  EndpointFactory.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 22.04.2023.
//

import SwiftUI

enum TMDB {
    static func configuration() -> Endpoint {
        Endpoint(baseURL: TMDBManager.TMDB_API_BASE_URL,
                 path: "configuration",
                 parameters: TMDBManager.shared.getDefaultParameters())
    }

    static func image(_ path: String) -> Endpoint {
        Endpoint(baseURL: TMDBManager.shared.TMDB_API_IMAGE_BASE_URL,
                 path: "w500\(path)")
    }
    
    static func trending() -> Endpoint {
        Endpoint(baseURL: TMDBManager.TMDB_API_BASE_URL,
                 path: "trending/all/week",
                 parameters: TMDBManager.shared.getDefaultParameters())
    }
    
    enum Movie {
        static func genre() -> Endpoint {
            Endpoint(baseURL: TMDBManager.TMDB_API_BASE_URL,
                     path: "genre/movie/list",
                     parameters: TMDBManager.shared.getDefaultParameters())
        }
        
        static func popular() -> Endpoint {
            Endpoint(baseURL: TMDBManager.TMDB_API_BASE_URL,
                     path: "movie/popular",
                     parameters: TMDBManager.shared.getDefaultParameters())
        }
        
        static func upcoming() -> Endpoint {
            Endpoint(baseURL: TMDBManager.TMDB_API_BASE_URL,
                     path: "movie/upcoming",
                     parameters: TMDBManager.shared.getDefaultParameters())
        }
        
        static func topRated() -> Endpoint {
            Endpoint(baseURL: TMDBManager.TMDB_API_BASE_URL,
                     path: "movie/top_rated",
                     parameters: TMDBManager.shared.getDefaultParameters())
        }
        
        static func detail(_ movieId: Int) -> Endpoint {
            Endpoint(baseURL: TMDBManager.TMDB_API_BASE_URL,
                     path: "movie/\(movieId)",
                     parameters: TMDBManager.shared.getDefaultParameters())
        }
        
        static func credits(_ movieId: Int) -> Endpoint {
            Endpoint(baseURL: TMDBManager.TMDB_API_BASE_URL,
                     path: "movie/\(movieId)/credits",
                     parameters: TMDBManager.shared.getDefaultParameters())
        }
    }
    
    enum TV {
        static func genre() -> Endpoint {
            Endpoint(baseURL: TMDBManager.TMDB_API_BASE_URL,
                     path: "genre/tv/list",
                     parameters: TMDBManager.shared.getDefaultParameters())
        }

        static func popular() -> Endpoint {
            Endpoint(baseURL: TMDBManager.TMDB_API_BASE_URL,
                     path: "tv/popular",
                     parameters: TMDBManager.shared.getDefaultParameters())
        }
        
        static func onAir() -> Endpoint {
            Endpoint(baseURL: TMDBManager.TMDB_API_BASE_URL,
                     path: "tv/on_the_air",
                     parameters: TMDBManager.shared.getDefaultParameters())
        }
        
        static func topRated() -> Endpoint {
            Endpoint(baseURL: TMDBManager.TMDB_API_BASE_URL,
                     path: "tv/top_rated",
                     parameters: TMDBManager.shared.getDefaultParameters())
        }
        
        static func detail(_ movieId: Int) -> Endpoint {
            Endpoint(baseURL: TMDBManager.TMDB_API_BASE_URL,
                     path: "tv/\(movieId)",
                     parameters: TMDBManager.shared.getDefaultParameters())
        }
        
        static func credits(_ movieId: Int) -> Endpoint {
            Endpoint(baseURL: TMDBManager.TMDB_API_BASE_URL,
                     path: "tv/\(movieId)/credits",
                     parameters: TMDBManager.shared.getDefaultParameters())
        }
    }
}
