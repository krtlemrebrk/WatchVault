//
//  StarsView.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 23.04.2023.
//

import SwiftUI

struct StarsView: View {
    var rating: CGFloat
    var maxRating: Int
    let starCount: Int = 5

    var body: some View {
        let stars = HStack(spacing: 0) {
            ForEach(0..<starCount, id: \.self) { _ in
                ImageLiteral.star.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 20, maxHeight: 20)
            }
        }

        stars.overlay(
            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: rating / CGFloat(maxRating) * proxy.size.width)
                        .foregroundColor(.yellow)
                }
            }
            .mask(stars)
        )
        .foregroundColor(.gray)
    }
}
