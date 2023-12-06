//
//  SectionType.swift
//  MovieDB
//
//  Created by Javier Munoz on 4/25/22.
//

import Foundation

enum Section: Int, CaseIterable {
    case nowPlaying
    case upComing
    case topRated
    
    var title: String {
        switch self {
        case .nowPlaying:
            return "Now Playing"
        case .upComing:
            return "Up Coming"
        case .topRated:
            return "Top Rated"
        }
    }
}
