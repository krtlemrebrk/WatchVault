//
//  MovieDetailScreen.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 23.04.2023.
//

import SwiftUI

struct MovieDetailScreen: View {
    
    @EnvironmentObject var appManager: AppManager
    @StateObject var tmdbManager = TMDBManager.shared
    @EnvironmentObject var navigationManager: NavigationManager
    var columnGrid: [GridItem] = [GridItem()]
    let movieId: Int
    @State var movie: Movie? = nil
    @State private var cast: [Cast] = [Cast]()

    @ViewBuilder
    var body: some View {
        ContainerView {
            ZStack {
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 20) {
                        ZStack(alignment: .top) {
                            if let imagePath = movie?.posterPath {
                                ImageView(path: imagePath, placeHolderImage: ImageLiteral.cover.image)
                                    .frame(maxWidth: .infinity)
                                    .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .top, endPoint: .bottom))
                            } else {
                                ImageLiteral.cover.image
                                    .frame(maxWidth: .infinity)
                                    .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .top, endPoint: .bottom))
                            }
                            HStack {
                                TextView(text: movie?.runtime?.minuteToHours() ?? "")
                                    .padding(5)
                                    .background(AppManager.shared.currentColorPalette.primary)
                                    .cornerRadius(5)
                                    .padding(.horizontal)
                                    
                                Spacer()
                                ZStack {
                                    Circle()
                                        .fill(AppManager.shared.currentColorPalette.background.opacity(0.8))
                                        .frame(maxWidth: 50, maxHeight: 50)

                                    Circle()
                                        .trim(from: 0, to: (movie?.rating ?? 0) / 10)
                                        .stroke(((movie?.rating ?? 0) / 10) > 0.75 ? Color.green : (((movie?.rating ?? 0) / 10) > 0.5 ? Color.orange : Color.red), style: StrokeStyle(lineWidth: 3.0, lineCap: .round))
                                        .rotationEffect(.degrees(270))
                                        .frame(maxWidth: 50, maxHeight: 50)
                                        .padding()
                                        .animation(Animation.easeOut(duration: 2), value: (movie?.rating ?? 0) / 10)
                                    
                                    TextView(text: (String(Int((movie?.rating ?? 0) * 10))))
                                }
                            }
                            
                            VStack(spacing: 20) {
                                Spacer()
                                TextView(text: movie?.title ?? "", font: .title)
                                HStack {
                                    if let genres = movie?.genreString {
                                        TextView(text: genres, alignment: .leading, lineLimit: 2)
                                    }
                                    Spacer()
                                    TextView(text: movie?.releaseDateRaw?.releaseYear() ?? "", font: .title3)
                                }
                            }.padding()
                        }.padding(.horizontal)

                        Divider()
                        TextView(text: movie?.overview ?? "").padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: columnGrid, alignment: .center, spacing: 15) {
                                ForEach(cast) { person in
                                    VStack {
                                        ImageView(path: person.profilePath, placeHolderImage: ImageLiteral.person.image)
                                        TextView(text: person.name ?? "", lineLimit: 1)
                                        TextView(text: "(\(person.character ?? ""))", lineLimit: 1)
                                    }.frame(maxWidth: 120)
                                }
                            }.padding(.horizontal).frame(maxHeight: 180)
                        }
                    }.padding(.vertical)
                }
                
                if movie == nil {
                    VStack {
                        CustomProgressView(isAnimating: .constant(true), currentOffset: .constant(0), refreshOffset: 100)
                        TextView(text: AppManager.shared.currentLocalization.loading)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(AppManager.shared.currentColorPalette.background)
                }
            }
        }
        .navigationTitle(movie?.title ?? AppManager.shared.currentLocalization.movieDetails)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    navigationManager.pop()
                } label: {
                    ImageLiteral.back.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }
            }
        }
        .onViewDidLoad {
            getContents()
        }
        .onReceive(AppManager.shared.languageChangePublisher) { update in
            if update {
                getContents()
            }
        }
    }
    
    func getContents() {
        Task {
            let movieResult = await TMDBManager.shared.getMovieDetail(movieId)
            await MainActor.run {
                self.movie = movieResult
            }
            
            let creditsResult = await TMDBManager.shared.getMovieCredits(movieId)
            await MainActor.run {
                self.cast = creditsResult
            }
        }
    }
}
