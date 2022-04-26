//
//  DetailViewController.swift
//  MovieDB
//
//  Created by Javier Munoz on 4/25/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    let movie: Movie!
    let detailView = DetailView()
    
    //MARK: -
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Life Cyle
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.configure(with: movie)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func loadView() {
        view = detailView
        view.backgroundColor = .systemBackground
    }
}
