//
//  HomeDataController.swift
//  MovieDB
//
//  Created by Javier Munoz on 4/26/22.
//

import Foundation

class HomeDataController {
    var sections = [Section]()
    
    //MARK: -
    func retrieveSections() async {
        let nowPlayingSection = await retrieveNowPlayingSection()
        let upComingSection = await retrieveUpComingSection()
        let topRatedSection = await retrieveTopRatedSection()
        sections.append(contentsOf: [nowPlayingSection, upComingSection, topRatedSection])
    }
    
    private func retrieveNowPlayingSection() async -> Section {
        var section = Section(title: "Now Playing", type: SectionType.largeTable.rawValue)
        do {
            let items = try await NetworkManager.shared.retrieveMovieCollection(from: .nowPlaying)
            section.items = items
        } catch {
            print("Could not retrieve items for Now Playing Section")
        }
        return section
    }
    
    private func retrieveUpComingSection() async -> Section {
        var section = Section(title: "Up Coming", type: SectionType.mediumTable.rawValue)
        do {
            let items = try await NetworkManager.shared.retrieveMovieCollection(from: .upcoming)
            section.items = items
        } catch {
            print("Could not retrieve items for Upcoming Section")
        }
        return section
    }
    
    private func retrieveTopRatedSection() async -> Section {
        var section = Section(title: "Top Rated", type: SectionType.mediumTable.rawValue)
        do {
            let items = try await NetworkManager.shared.retrieveMovieCollection(from: .topRated)
            section.items = items
        } catch {
            print("Could not retrieve items for Top Rated Section")
        }
        return section
    }
}
