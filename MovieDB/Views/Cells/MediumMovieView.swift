//
//  MediumMovieView.swift
//  MovieDB
//
//  Created by Javier Munoz on 12/6/23.
//

import SwiftUI

struct MediumMovieView: View {
    let movie: Movie
    
    var baseURL: String {
        Constants.baseImageURL + movie.backdropPath
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: baseURL)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                EmptyView()
            }

            Text(movie.title)
                .lineLimit(1)
        }
    }
}

#Preview {
    MediumMovieView(movie: .parasiteMock)
        .frame(width: 246, height: 200)
}
