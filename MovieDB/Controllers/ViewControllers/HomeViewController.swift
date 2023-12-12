//
//  HomeViewController.swift
//  MovieDB
//
//  Created by Javier Munoz on 4/25/22.
//

import SwiftUI
import UIKit

class HomeViewController: UIViewController {
    let dataController = HomeDataController()
    var collectionView: UICollectionView! = nil
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>! = nil
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "MovieDB"
    
        configureHierarchy()
        configureDataSource()
        loadMovies()
    }
    
    private func loadMovies() {
        Task {
            await dataController.retrieveSections()
            configureSnapshot()
        }
    }
    
    private func configureSnapshot() {
        if !dataController.nowPlaying.isEmpty {
            var nowPlaying = NSDiffableDataSourceSectionSnapshot<Movie>()
            nowPlaying.append(dataController.nowPlaying)
            dataSource.apply(nowPlaying, to: .nowPlaying, animatingDifferences: true)
        }
        
        if !dataController.upcoming.isEmpty {
            var upcoming = NSDiffableDataSourceSectionSnapshot<Movie>()
            upcoming.append(dataController.upcoming)
            dataSource.apply(upcoming, to: .upComing, animatingDifferences: true)
        }
        
        if !dataController.topRated.isEmpty {
            var topRated = NSDiffableDataSourceSectionSnapshot<Movie>()
            topRated.append(dataController.topRated)
            dataSource.apply(topRated, to: .topRated, animatingDifferences: true)
        }
    }
}

extension HomeViewController {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
    }
    
    func createLayout() -> UICollectionViewLayout {
        let sectionProvider = {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            
            let section: NSCollectionLayoutSection
            
            switch sectionKind {
            case .nowPlaying:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), 
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(185), 
                                                       heightDimension: .absolute(276))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
            case .upComing, .topRated:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), 
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(246), 
                                                       heightDimension: .absolute(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
            }

            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                         heightDimension: .estimated(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterSize,
                elementKind: SectionHeader.reuseIdentifier, alignment: .top
            )
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    func configureDataSource() {
        // create registrations up front, then choose the appropriate one to use in the cell provider
        let largeMovieCellRegistration = createLargeCellRegistration()
        let mediumMovieCellRegistration = createMediumCellRegistration()
        let headerViewRegistration = createHeaderViewRegistration()

        // data source + cells
        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: collectionView) {
            (collectionView, indexPath, movie) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section") }
            switch section {
            case .nowPlaying:
                return collectionView.dequeueConfiguredReusableCell(
                    using: largeMovieCellRegistration,
                    for: indexPath,
                    item: movie
                )
            case .upComing, .topRated:
                return collectionView.dequeueConfiguredReusableCell(
                    using: mediumMovieCellRegistration,
                    for: indexPath,
                    item: movie
                )
            }
        }
        
        // header view
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: headerViewRegistration,
                for: index
            )
        }
    }
    
    func createHeaderViewRegistration() -> UICollectionView.SupplementaryRegistration<SectionHeader> {
        return UICollectionView.SupplementaryRegistration<SectionHeader>(
            elementKind: SectionHeader.reuseIdentifier
        ) { supplementaryView, elementKind, indexPath in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section") }
            supplementaryView.titleLabel.text = "\(section.title)"
        }
    }
    
    func createLargeCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewCell, Movie> {
        return UICollectionView.CellRegistration<UICollectionViewCell, Movie> { (cell, indexPath, movie) in
            cell.contentConfiguration = UIHostingConfiguration {
                LargeMovieView(movie: movie)
            }
        }
    }
    
    func createMediumCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewCell, Movie> {
        return UICollectionView.CellRegistration<UICollectionViewCell, Movie> { (cell, indexPath, movie) in
            cell.contentConfiguration = UIHostingConfiguration {
                MediumMovieView(movie: movie)
            }
            // can mess with margins here with .margins
        }
    }
}

//MARK: - CollectionView Delegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedMovie = dataSource.itemIdentifier(for: indexPath) else {
            collectionView.deselectItem(at: indexPath, animated: true)
            return
        }
        
        let detailView = UIHostingController(rootView: MovieDetailView(movie: selectedMovie))
        detailView.title = selectedMovie.title
        navigationController?.pushViewController(detailView, animated: true)
    }
}
