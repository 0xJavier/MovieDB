//
//  DetailView.swift
//  MovieDB
//
//  Created by Javier Munoz on 4/25/22.
//

import UIKit

class DetailView: UIView {
    
    let titleLabel = UILabel()
    let backdropImage = MDBImageView(frame: .zero)
    let overviewLabel = UILabel()
    let releaseDateLabel = UILabel()
    
    //MARK: -
    init() {
        super.init(frame: .zero)
        
        titleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        overviewLabel.numberOfLines = 0
        backdropImage.translatesAutoresizingMaskIntoConstraints = false
        backdropImage.layer.cornerRadius = 0
        
        let stackview = UIStackView(arrangedSubviews: [titleLabel, backdropImage,overviewLabel, releaseDateLabel])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.spacing = 16
        addSubview(stackview)
        
        NSLayoutConstraint.activate([
            backdropImage.heightAnchor.constraint(equalToConstant: 208),
            stackview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackview.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackview.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @MainActor func configure(with movie: Movie) {
        titleLabel.text = movie.title
        backdropImage.setImage(with: movie, type: .backdropImage)
        overviewLabel.text = movie.overview
        releaseDateLabel.text = "Release date: \(movie.releaseDate)"
    }
}
