//
//  SectionType.swift
//  MovieDB
//
//  Created by Javier Munoz on 4/25/22.
//

import Foundation

enum SectionType: String {
    case largeTable
    case mediumTable
}

struct Section: Hashable {
    let title: String
    let type: String
    var items: [Movie] = []
}
