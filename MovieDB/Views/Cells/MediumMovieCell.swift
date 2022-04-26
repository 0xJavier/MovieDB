//
//  MediumMovieCell.swift
//  MovieDB
//
//  Created by Javier Munoz on 4/25/22.
//

import UIKit

class MediumMovieCell: UICollectionViewCell, SelfConfigureCell {
    static var reuseIdentifier: String = "MediumMovieCell"
    let imageView = MDBImageView(frame: .zero)
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.font = .preferredFont(forTextStyle: .body)
        titleLabel.textColor = .label
        
        let stackview = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.setCustomSpacing(10, after: imageView)
        contentView.addSubview(stackview)
        stackview.center(in: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: Movie) {
        imageView.setImage(with: movie, type: .posterImage)
        titleLabel.text = movie.title
    }
}
