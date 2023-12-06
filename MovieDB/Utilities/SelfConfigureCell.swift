//
//  SelfConfigureCell.swift
//  MovieDB
//
//  Created by Javier Munoz on 4/25/22.
//

import Foundation

// protocol for all collection view cells
protocol SelfConfigureCell {
    // Takes a movie and configures the cell's UI
    func configure(with movie: Movie)
}
