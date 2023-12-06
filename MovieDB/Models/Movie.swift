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

extension Movie {
    static let spiritedAwayMock = Movie(
        id: 129,
        title: "Spirited Away",
        releaseDate: "2001-07-20",
        overview: """
        A young girl, Chihiro, becomes trapped in a strange new world of spirits.
        When her parents undergo a mysterious transformation, 
        she must call upon the courage she never knew she had to free her family.
        """,
        posterPath: "/39wmItIWsg5sZMyRUHLkWBcuVCM.jpg",
        backdropPath: "/mSDsSDwaP3E7dEfUPWy4J0djt4O.jpg"
    )
    
    static let parasiteMock = Movie(
        id: 496243,
        title: "Parasite",
        releaseDate: "2019-05-30",
        overview: """
        All unemployed, Ki-taek\'s family takes peculiar interest in the wealthy and glamorous Parks
        for their livelihood until they get entangled in an unexpected incident.
        """,
        posterPath: "/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg",
        backdropPath: "/hiKmpZMGZsrkA3cdce8a7Dpos1j.jpg"
    )
}
