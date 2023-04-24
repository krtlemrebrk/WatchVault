//
//  Localization.swift
//  WatchVault
//
//  Created by Kartal Emre Buruk on 8.04.2023.
//

import SwiftUI

enum LocalizedKeys {
    case system
    case dark
    case light
    case welcome
    case welcomeDescription
    case welcomeStart
    case login
    case signUp
    case email
    case password
    case loginRoute
    case signUpRoute
    case loading
    case popular
    case upcoming
    case topRated
    case onAir
    case movieDetails
    case tvDetails
    case movie
    case tv
    case settings
    case hour
    case hourShort
    case minute
    case minuteShort
    case season
    case seasonShort
    case episode
    case episodeShort
    
    var value: String {
        switch self {
        case .system: return AppManager.shared.currentLocalization.system
        case .dark: return AppManager.shared.currentLocalization.dark
        case .light: return AppManager.shared.currentLocalization.light
        case .welcome: return AppManager.shared.currentLocalization.welcome
        case .welcomeDescription: return AppManager.shared.currentLocalization.welcomeDescription
        case .welcomeStart: return AppManager.shared.currentLocalization.welcomeStart
        case .login: return AppManager.shared.currentLocalization.login
        case .signUp: return AppManager.shared.currentLocalization.signUp
        case .email: return AppManager.shared.currentLocalization.email
        case .password: return AppManager.shared.currentLocalization.password
        case .loginRoute: return AppManager.shared.currentLocalization.loginRoute
        case .signUpRoute: return AppManager.shared.currentLocalization.signUpRoute
        case .loading: return AppManager.shared.currentLocalization.loading
        case .popular: return AppManager.shared.currentLocalization.popular
        case .upcoming: return AppManager.shared.currentLocalization.upcoming
        case .topRated: return AppManager.shared.currentLocalization.topRated
        case .onAir: return AppManager.shared.currentLocalization.onAir
        case .movieDetails: return AppManager.shared.currentLocalization.movieDetails
        case .tvDetails: return AppManager.shared.currentLocalization.tvDetails
        case .movie: return AppManager.shared.currentLocalization.movie
        case .tv: return AppManager.shared.currentLocalization.tv
        case .settings: return AppManager.shared.currentLocalization.settings
        case .hour: return AppManager.shared.currentLocalization.hour
        case .hourShort: return AppManager.shared.currentLocalization.hourShort
        case .minute: return AppManager.shared.currentLocalization.minute
        case .minuteShort: return AppManager.shared.currentLocalization.minuteShort
        case .season: return AppManager.shared.currentLocalization.season
        case .seasonShort: return AppManager.shared.currentLocalization.seasonShort
        case .episode: return AppManager.shared.currentLocalization.episode
        case .episodeShort: return AppManager.shared.currentLocalization.episodeShort
        }
    }
}

protocol Localization {
    var system: String { get }
    var dark: String { get }
    var light: String { get }
    var welcome: String { get }
    var welcomeDescription: String { get }
    var welcomeStart: String { get }
    var login: String { get }
    var signUp: String { get }
    var email: String { get }
    var password: String { get }
    var loginRoute: String { get }
    var signUpRoute: String { get }
    var loading: String { get }
    var popular: String { get }
    var upcoming: String { get }
    var topRated: String { get }
    var onAir: String { get }
    var movieDetails: String { get }
    var tvDetails: String { get }
    var movie: String { get }
    var tv: String { get }
    var settings: String { get }
    var hour: String { get }
    var hourShort: String { get }
    var minute: String { get }
    var minuteShort: String { get }
    var season: String { get }
    var seasonShort: String { get }
    var episode: String { get }
    var episodeShort: String { get }
}

struct LocalizationTR: Localization {
    var system: String = "Sistem Varsayılan"
    var dark: String = "Koyu Mod"
    var light: String = "Açık Mod"
    var welcome: String = "Hoşgeldiniz"
    var welcomeDescription: String = "Keşfedilecek milyonlarca film, dizi ve insan. Şimdi keşfedin."
    var welcomeStart: String = "Hadi başlayalım."
    var login: String = "Giriş Yap"
    var signUp: String = "Kayıt ol"
    var email: String = "Email"
    var password: String = "Şifre"
    var loginRoute: String = "Zaten bir hesabınız var mı? Giriş yapın"
    var signUpRoute: String = "Hesabınız yok mu? Kayıt olun"
    var loading: String = "Yükleniyor"
    var popular: String = "Popüler"
    var upcoming: String = "Yakında"
    var topRated: String = "En Çok Beğenilenler"
    var onAir: String = "Yayında"
    var movieDetails: String = "Film Detayları"
    var tvDetails: String = "TV Show Detayları"
    var movie: String = "Film"
    var tv: String = "TV"
    var settings: String = "Ayarlar"
    var hour: String = "Saat"
    var hourShort: String = "s"
    var minute: String = "Dakika"
    var minuteShort: String = "d"
    var season: String = "Sezon"
    var seasonShort: String = "S"
    var episode: String = "Bölüm"
    var episodeShort: String = "B"
}

struct LocalizationEN: Localization {
    var system: String = "System Default"
    var dark: String = "Dark Mode"
    var light: String = "Light Mode"
    var welcome: String = "Welcome"
    var welcomeDescription: String = "Millions of movies, TV shows and people to discover. Explore now."
    var welcomeStart: String = "Let's get started."
    var login: String = "Login"
    var signUp: String = "Sign up"
    var email: String = "Email"
    var password: String = "Password"
    var loginRoute: String = "Already have an account? Login"
    var signUpRoute: String = "Don't have an account? Sign up"
    var loading: String = "Loading"
    var popular: String = "Popular"
    var upcoming: String = "Upcoming"
    var topRated: String = "Top Rated"
    var onAir: String = "On Air"
    var movieDetails: String = "Movie Details"
    var tvDetails: String = "TV Show Details"
    var movie: String = "Movie"
    var tv: String = "TV"
    var settings: String = "Settings"
    var hour: String = "Hour"
    var hourShort: String = "h"
    var minute: String = "Minute"
    var minuteShort: String = "m"
    var season: String = "Season(s)"
    var seasonShort: String = "S"
    var episode: String = "Episode(s)"
    var episodeShort: String = "E"
}
