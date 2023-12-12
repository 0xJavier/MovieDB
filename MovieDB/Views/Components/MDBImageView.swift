//
//  MDBImageView.swift
//  MovieDB
//
//  Created by Javier Munoz on 4/25/22.
//

import UIKit

class MDBImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        contentMode = .scaleAspectFill
        backgroundColor = .secondarySystemBackground
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setImage(with movie: Movie, type: ImageType) {
        Task {
            do {
                image = try await NetworkManager.shared.retrieveMovieImage(from: movie, as: type)
            } catch {
                print("LOG: Could not download movie image: MDBImageView -> setImage()")
            }
        }
    }
}
