//
//  SelfConfigureCell.swift
//  MovieDB
//
//  Created by Javier Munoz on 4/25/22.
//

import Foundation

protocol SelfConfigureCell {
    static var reuseIdentifier: String { get }
    func configure(with movie: Movie)
}
