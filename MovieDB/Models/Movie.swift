//
//  Movie.swift
//  MovieDB
//
//  Created by Javier Munoz on 4/25/22.
//

import Foundation

struct Movie: Decodable, Hashable {
    let uuid = UUID()
    let id: Int
    let title: String
    let releaseDate: String
    let overview: String
    let posterPath: String
    let backdropPath: String
    
    // exclude uuid to ensure the same movie can be present in multiple sections
    enum CodingKeys: String, CodingKey {
        case id, title, releaseDate, overview, posterPath, backdropPath
    }
}

struct MovieResponse: Decodable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
