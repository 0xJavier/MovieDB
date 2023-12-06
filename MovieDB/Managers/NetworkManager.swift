//
//  NetworkManager.swift
//  MovieDB
//
//  Created by Javier Munoz on 4/25/22.
//

import UIKit

protocol NetworkService {
    func retrieveMovieCollection(from collection: MovieCollection) async throws -> [Movie]
    func retrieveMovieImage(from movie: Movie, as type: ImageType) async throws -> UIImage?
}

//MARK: -
class NetworkManager: NetworkService {
    static let shared = NetworkManager()
    
    private let decoder = JSONDecoder()
    
    private let baseMovieURL = "https://api.themoviedb.org/3/movie/"
    private let baseImageURL = "https://image.tmdb.org/t/p/w500"
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    //MARK: -
    func retrieveMovieCollection(from collection: MovieCollection) async throws -> [Movie] {
        let endpoint = baseMovieURL + "\(collection.rawValue)?api_key=\(Constants.apiKey)"
        
        guard let url = URL(string: endpoint) else {
            print("LOG: Could not turn generated endpoint to URL: NetworkManager -> retrieveMovieCollection()")
            return []
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("LOG: Could not get response from url: NetworkManager -> retrieveMovieCollection()")
            return []
        }
        
        let movieResponse = try decoder.decode(MovieResponse.self, from: data)
        return movieResponse.movies
    }
    
    //MARK: -
    func retrieveMovieImage(from movie: Movie, as type: ImageType) async throws -> UIImage? {
        var endpoint = baseImageURL
        
        switch type {
        case .posterImage: endpoint += movie.posterPath
        case .backdropImage: endpoint += movie.backdropPath
        }
        
        guard let url = URL(string: endpoint) else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else { return nil }
        return image
    }
}
