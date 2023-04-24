//
//  TVDetailScreen.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 24.04.2023.
//

import SwiftUI

struct TVDetailScreen: View {
    
    @EnvironmentObject var appManager: AppManager
    @StateObject var tmdbManager = TMDBManager.shared
    @EnvironmentObject var navigationManager: NavigationManager
    var columnGrid: [GridItem] = [GridItem()]
    let tvId: Int
    @State var tvShow: TVShow? = nil
    @State private var cast: [Cast] = [Cast]()

    @ViewBuilder
    var body: some View {
        ContainerView {
            ZStack {
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 20) {
                        ZStack(alignment: .top) {
                            if let imagePath = tvShow?.posterPath {
                                ImageView(path: imagePath, placeHolderImage: ImageLiteral.cover.image)
                                    .frame(maxWidth: .infinity)
                                    .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .top, endPoint: .bottom))
                            } else {
                                ImageLiteral.cover.image
                                    .frame(maxWidth: .infinity)
                                    .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .top, endPoint: .bottom))
                            }
                            HStack {
                                if let numberOfSeasons = tvShow?.numberOfSeasons {
                                    TextView(text: numberOfSeasons.seasons())
                                        .padding(5)
                                        .background(AppManager.shared.currentColorPalette.primary)
                                        .cornerRadius(5)
                                        .padding(.horizontal)
                                }
                                Spacer()
                                ZStack {
                                    Circle()
                                        .fill(AppManager.shared.currentColorPalette.background.opacity(0.8))
                                        .frame(maxWidth: 50, maxHeight: 50)

                                    Circle()
                                        .trim(from: 0, to: (tvShow?.rating ?? 0) / 10)
                                        .stroke(Color.green, style: StrokeStyle(lineWidth: 3.0, lineCap: .round))
                                        .rotationEffect(.degrees(270))
                                        .frame(maxWidth: 50, maxHeight: 50)
                                        .padding()
                                        .animation(Animation.easeOut(duration: 2), value: (tvShow?.rating ?? 0) / 10)
                                    
                                    TextView(text: (String(Int((tvShow?.rating ?? 0) * 10))))
                                }
                            }
                            
                            VStack(spacing: 20) {
                                Spacer()
                                TextView(text: tvShow?.title ?? "", font: .title)
                                HStack {
                                    if let genres = tvShow?.genreString {
                                        TextView(text: genres, alignment: .leading, lineLimit: 2)
                                    }
                                    Spacer()
                                    TextView(text: tvShow?.airDateRaw?.releaseYear() ?? "", font: .title3)
                                }
                            }.padding()
                        }.padding(.horizontal)
                        if let numberOfEpisodes = tvShow?.numberOfEpisodes, let runtime = tvShow?.averageRuntime {
                            HStack {
                                TextView(text: numberOfEpisodes.episodes(), lineLimit: 1)
                                Spacer()
                                TextView(text: runtime.minuteToHours(), lineLimit: 1)
                            }.padding(.horizontal)
                        } else if let numberOfEpisodes = tvShow?.numberOfEpisodes {
                            TextView(text: numberOfEpisodes.episodes(), lineLimit: 1).padding(.horizontal)
                        } else if let runtime = tvShow?.averageRuntime {
                            TextView(text: runtime.minuteToHours(), lineLimit: 1).padding(.horizontal)
                        }
                        Divider()
                        TextView(text: tvShow?.overview ?? "").padding(.horizontal)
                        
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
                
                if tvShow == nil {
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
        .navigationTitle(tvShow?.title ?? AppManager.shared.currentLocalization.tvDetails)
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
            let tvResult = await TMDBManager.shared.getTVShowDetail(tvId)
            await MainActor.run {
                self.tvShow = tvResult
            }
            
            let creditsResult = await TMDBManager.shared.getTVCredits(tvId)
            await MainActor.run {
                self.cast = creditsResult
            }
        }
    }
}
