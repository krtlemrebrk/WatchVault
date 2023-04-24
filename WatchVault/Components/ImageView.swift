//
//  ImageView.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 23.04.2023.
//

import SwiftUI

struct ImageView: View {
    let path: String?
    let placeHolderImage: Image
    let contentMode: ContentMode
    let cornerRadius: CGFloat
    @State var image: Image? = nil
    
    init(path: String?, placeHolderImage: Image, contentMode: ContentMode = .fit, cornerRadius: CGFloat = 10) {
        self.path = path
        self.placeHolderImage = placeHolderImage
        self.contentMode = contentMode
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        getImage()
            .resizable()
            .aspectRatio(contentMode: contentMode)
            .cornerRadius(cornerRadius)
            .task {
                guard let path = path?.trimmingCharacters(in: .whitespacesAndNewlines), !path.isEmpty else { return }
                let result = await TMDBManager.shared.downloadImage(from: path)
                await MainActor.run {
                    self.image = result
                }
            }
    }
    
    func getImage() -> Image {
        guard let image else { return placeHolderImage }
        return image
    }
}
