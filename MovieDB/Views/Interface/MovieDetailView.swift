//
//  MovieDetailView.swift
//  MovieDB
//
//  Created by Javier Munoz on 12/12/23.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    
    var imageURL: String {
        Constants.baseImageURL + movie.posterPath
    }
    
    var releaseDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: movie.releaseDate) {
            dateFormatter.dateFormat = "MMMM d, yyyy"
            return dateFormatter.string(from: date)
        } else {
            return movie.releaseDate
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(width: 200)
            
            Button {
                print("Button Tapped!")
            } label: {
                Label("Start Watching", systemImage: "play.fill")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 5)
            }
            .buttonStyle(.borderedProminent)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Synopsis")
                    .font(.title3)
                    .bold()
                
                Text(movie.overview)
                
                Text("Release Date: \(releaseDate)")
                    .bold()
                    .padding(.top, 15)
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    MovieDetailView(movie: .parasiteMock)
}
