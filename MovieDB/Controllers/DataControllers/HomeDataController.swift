//
//  HomeDataController.swift
//  MovieDB
//
//  Created by Javier Munoz on 4/26/22.
//

import Foundation

class HomeDataController {
    var nowPlaying = [Movie]()
    var upcoming = [Movie]()
    var topRated = [Movie]()
    
    //MARK: -    
    func retrieveSections() async {
        nowPlaying = await retrieveNowPlayingSection()
        upcoming = await retrieveUpComingSection()
        topRated = await retrieveTopRatedSection()
    }
    
    private func retrieveNowPlayingSection() async -> [Movie] {
        do {
            return try await NetworkManager.shared.retrieveMovieCollection(from: .nowPlaying)
        } catch {
            print("Could not retrieve items for Now Playing Section")
            return []
        }
    }
    
    private func retrieveUpComingSection() async -> [Movie] {
        do {
            return try await NetworkManager.shared.retrieveMovieCollection(from: .upcoming)
        } catch {
            print("Could not retrieve items for Upcoming Section")
            return []
        }
    }
    
    private func retrieveTopRatedSection() async -> [Movie] {
        do {
            return try await NetworkManager.shared.retrieveMovieCollection(from: .topRated)
        } catch {
            print("Could not retrieve items for Top Rated Section")
            return []
        }
    }
}
