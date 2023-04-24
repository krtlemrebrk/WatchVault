//
//  MovieScreen.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 18.04.2023.
//

import SwiftUI

struct MovieScreen: View {
    
    @EnvironmentObject var appManager: AppManager
    @StateObject var tmdbManager = TMDBManager.shared
    @StateObject var navigationManager = NavigationManager()
    @State private var isAnimating: Bool = false
    @State private var headerHeight: CGFloat = 0
    @State private var headerOffset: CGFloat = 0
    @State private var popularMovies: [Movie] = [Movie]()
    @State private var upcomingMovies: [Movie] = [Movie]()
    @State private var topRatedMovies: [Movie] = [Movie]()

    var body: some View {
        NavigationController {
            ContainerView {
                AnimatedVerticalScrollView(isAnimating: $isAnimating, headerHeight: $headerHeight, headerOffset: $headerOffset) {
                    HStack {
                        ImageLiteral.appLogo.image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                        Spacer()
                    }
                    .opacity((headerHeight + headerOffset) / headerHeight)
                    .padding()
                    .background(Color(uiColor: UIColor.appBackground))
                    .foregroundColor(Color(uiColor: UIColor.appForeground))
                    .overlay(alignment: .bottom) {
                        Divider()
                    }
                } content: {
                    ZStack {
                        VStack {
                            popularMoviesSection
                            upcomingMoviesSection
                            Divider().padding(.top)
                            topRatedMoviesSection
                        }.padding(.vertical).background(Colors.background.value)
                        
                        if popularMovies.isEmpty || upcomingMovies.isEmpty || topRatedMovies.isEmpty {
                            VStack {
                                CustomProgressView(isAnimating: .constant(true), currentOffset: .constant(0), refreshOffset: 100)
                                TextView(text: AppManager.shared.currentLocalization.loading)
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(AppManager.shared.currentColorPalette.background)
                        }
                    }
                } refreshAction: {
                    // TODO: Replace with real refresh action.
                    print("RefreshAction")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        self.isAnimating = false
                    }
                }
            }
        }
        .environmentObject(navigationManager)
        .onViewDidLoad {
            getContents()
        }
        .onReceive(AppManager.shared.languageChangePublisher) { update in
            if update {
                getContents()
            }
        }
    }
    
    var popularMoviesSection: some View {
        ScrollCollectionView(axis: .horizontal, title: AppManager.shared.currentLocalization.popular, frameLimit: 180) {
            ForEach(self.popularMovies) { movie in
                Button {
                    guard let movieId = movie.id else { return }
                    navigationManager.push(.movieDetail(movieId))
                } label: {
                    ImageView(path: movie.posterPath, placeHolderImage: ImageLiteral.cover.image)
                }
            }
        }
    }
    
    var upcomingMoviesSection: some View {
        ScrollCollectionView(axis: .horizontal, title: AppManager.shared.currentLocalization.upcoming, frameLimit: 180) {
            ForEach(self.upcomingMovies) { movie in
                Button {
                    guard let movieId = movie.id else { return }
                    navigationManager.push(.movieDetail(movieId))
                } label: {
                    ImageView(path: movie.posterPath, placeHolderImage: ImageLiteral.cover.image)
                }
            }
        }
    }
    
    var topRatedMoviesSection: some View {
        TabCollectionView(title:  AppManager.shared.currentLocalization.topRated, frameLimit: 550) {
            ForEach(self.topRatedMovies) { movie in
                Button {
                    guard let movieId = movie.id else { return }
                    navigationManager.push(.movieDetail(movieId))
                } label: {
                    VStack {
                        ImageView(path: movie.posterPath, placeHolderImage: ImageLiteral.cover.image)
                        HStack {
                            TextView(text: movie.releaseDateRaw?.releaseYear() ?? "", font: .title3)
                            Spacer()
                            StarsView(rating: CGFloat(movie.rating ?? 0), maxRating: 10)
                        }
                        TextView(text: movie.title ?? "", font: .title2)
                        
                        Spacer()
                    }.foregroundColor(AppManager.shared.currentColorPalette.foreground)
                }
            }.padding(.horizontal, 50)
        }
    }
    
    func getContents() {
        Task {
            await TMDBManager.shared.getMovieGenres()
            let popularMovieResults = await TMDBManager.shared.getPopularMovies()
            let upcomingMovieResults = await TMDBManager.shared.getUpcomingMovies()
            let topRatedMovieResults = await TMDBManager.shared.getTopRatedMovies()
            await MainActor.run {
                self.popularMovies = popularMovieResults
                self.upcomingMovies = upcomingMovieResults
                self.topRatedMovies = topRatedMovieResults
            }
        }
    }
}
