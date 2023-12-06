//
//  MediumMovieCell.swift
//  MovieDB
//
//  Created by Javier Munoz on 4/25/22.
//

import UIKit

class MediumMovieCell: UICollectionViewCell, SelfConfigureCell {
    let imageView = MDBImageView(frame: .zero)
    
    let titleLabel: UILabel = .build { label in
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .label
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.setCustomSpacing(10, after: imageView)
        contentView.addSubview(stackView)
        stackView.center(in: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: Movie) {
        imageView.setImage(with: movie, type: .posterImage)
        titleLabel.text = movie.title
    }
}
