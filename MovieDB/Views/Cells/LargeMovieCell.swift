//
//  LargeMovieCell.swift
//  MovieDB
//
//  Created by Javier Munoz on 4/25/22.
//

import UIKit

class LargeMovieCell: UICollectionViewCell, SelfConfigureCell {
    
    static var reuseIdentifier: String = "LargeMovieCell"
    private let imageView = MDBImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.center(in: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: Movie) {
        imageView.setImage(with: movie, type: .posterImage)
    }
}
