//
//  MovieResponse.swift
//  MovieDB
//
//  Created by Javier Munoz on 4/25/22.
//

import Foundation

struct MovieResponse: Decodable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
