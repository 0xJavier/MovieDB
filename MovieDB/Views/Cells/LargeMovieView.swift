//
//  LargeMovieView.swift
//  MovieDB
//
//  Created by Javier Munoz on 12/6/23.
//

import SwiftUI

struct LargeMovieView: View {
    let movie: Movie
    
    var baseURL: String {
        Constants.baseImageURL + movie.posterPath
    }
    
    var body: some View {
        AsyncImage(url: URL(string: baseURL)) { image in
            image
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
        } placeholder: {
            ProgressView()
        }
    }
}

#Preview {
    LargeMovieView(movie: .spiritedAwayMock)
        .frame(width: 185, height: 276)
}
