//
//  TVScreen.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 24.04.2023.
//

import SwiftUI

struct TVScreen: View {
    
    @EnvironmentObject var appManager: AppManager
    @StateObject var tmdbManager = TMDBManager.shared
    @StateObject var navigationManager = NavigationManager()
    @State private var isAnimating: Bool = false
    @State private var headerHeight: CGFloat = 0
    @State private var headerOffset: CGFloat = 0
    @State private var popularTVShows: [TVShow] = [TVShow]()
    @State private var onAirTVShows: [TVShow] = [TVShow]()
    @State private var topRatedTVShows: [TVShow] = [TVShow]()

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
                            popularTVShowsSection
                            onAirTVShowsSection
                            Divider().padding(.top)
                            topRatedTVShowsSection
                        }.padding(.vertical).background(Colors.background.value)
                        
                        if popularTVShows.isEmpty || onAirTVShows.isEmpty || topRatedTVShows.isEmpty {
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
    
    var popularTVShowsSection: some View {
        ScrollCollectionView(axis: .horizontal, title: AppManager.shared.currentLocalization.popular, frameLimit: 180) {
            ForEach(self.popularTVShows) { tv in
                Button {
                    guard let tvId = tv.id else { return }
                    navigationManager.push(.tvDetail(tvId))
                } label: {
                    ImageView(path: tv.posterPath, placeHolderImage: ImageLiteral.cover.image)
                }
            }
        }
    }
    
    var onAirTVShowsSection: some View {
        ScrollCollectionView(axis: .horizontal, title: AppManager.shared.currentLocalization.onAir, frameLimit: 180) {
            ForEach(self.onAirTVShows) { tv in
                Button {
                    guard let tvId = tv.id else { return }
                    navigationManager.push(.tvDetail(tvId))
                } label: {
                    ImageView(path: tv.posterPath, placeHolderImage: ImageLiteral.cover.image)
                }
            }
        }
    }
    
    var topRatedTVShowsSection: some View {
        TabCollectionView(title:  AppManager.shared.currentLocalization.topRated, frameLimit: 550) {
            ForEach(self.topRatedTVShows) { tv in
                Button {
                    guard let tvId = tv.id else { return }
                    navigationManager.push(.tvDetail(tvId))
                } label: {
                    VStack {
                        ImageView(path: tv.posterPath, placeHolderImage: ImageLiteral.cover.image)
                        HStack {
                            TextView(text: tv.airDateRaw?.releaseYear() ?? "", font: .title3)
                            Spacer()
                            StarsView(rating: CGFloat(tv.rating ?? 0), maxRating: 10)
                        }
                        TextView(text: tv.title ?? "", font: .title2)
                        
                        Spacer()
                    }.foregroundColor(AppManager.shared.currentColorPalette.foreground)
                }
            }.padding(.horizontal, 50)
        }
    }
    
    func getContents() {
        Task {
            await TMDBManager.shared.getTVGenres()
            let popularTVShowResults = await TMDBManager.shared.getPopularTVShows()
            let onAirTVShowResults = await TMDBManager.shared.getOnAirTVShows()
            let topRatedTVShowResults = await TMDBManager.shared.getTopRatedTVShows()
            await MainActor.run {
                self.popularTVShows = popularTVShowResults
                self.onAirTVShows = onAirTVShowResults
                self.topRatedTVShows = topRatedTVShowResults
            }
        }
    }
}
