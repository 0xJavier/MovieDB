//
//  Movie.swift
//  MovieDB
//
//  Created by Javier Munoz on 4/25/22.
//

import Foundation

struct Movie: Decodable, Hashable {
    let id: Int
    let title: String
    let releaseDate: String
    let overview: String
    let posterPath: String
    let backdropPath: String
        
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
