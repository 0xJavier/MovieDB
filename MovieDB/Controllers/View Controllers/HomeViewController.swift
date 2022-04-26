//
//  HomeViewController.swift
//  MovieDB
//
//  Created by Javier Munoz on 4/25/22.
//

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
        Task.init {
            await dataController.retrieveSections()
            reloadData()
        }
    }
}

//MARK: - Configure CollectionView
extension HomeViewController {
    func configure<T: SelfConfigureCell>(_ cellType: T.Type, with movie: Movie, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configure(with: movie)
        return cell
    }
    
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.delegate = self
        
        collectionView.register(SectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeader.reuseIdentifier)
        collectionView.register(LargeMovieCell.self, forCellWithReuseIdentifier: LargeMovieCell.reuseIdentifier)
        collectionView.register(MediumMovieCell.self, forCellWithReuseIdentifier: MediumMovieCell.reuseIdentifier)
    }
    
    //MARK: - Configure Data source
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: collectionView) { collectionView, indexPath, movie in
            switch self.dataController.sections[indexPath.section].type {
            case SectionType.largeTable.rawValue:
                return self.configure(LargeMovieCell.self, with: movie, for: indexPath)
            case SectionType.mediumTable.rawValue:
                return self.configure(MediumMovieCell.self, with: movie, for: indexPath)
            default:
                return self.configure(LargeMovieCell.self, with: movie, for: indexPath)
            }
        }
        
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader else {
                return nil
            }
            
            guard let firstMovie = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstMovie) else { return nil }
            if section.title.isEmpty { return nil }
            sectionHeader.titleLabel.text = section.title
            return sectionHeader
        }
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections(dataController.sections)
        for section in dataController.sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource.apply(snapshot)
    }
    
    //MARK: - Create Compositional Layouts
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = self.dataController.sections[sectionIndex]
            switch section.type {
            case SectionType.largeTable.rawValue:
                return self.createLargeTableSection(using: section)
            case SectionType.mediumTable.rawValue:
                return self.createMediumTableSection(using: section)
            default:
                return self.createLargeTableSection(using: section)
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    func createLargeTableSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.trailing = 16
        item.contentInsets.leading = 16
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(185), heightDimension: .absolute(276))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [createHeaderView()]
        
        return section
    }
    
    func createMediumTableSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.trailing = 16
        item.contentInsets.leading = 16
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(246), heightDimension: .absolute(168))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [createHeaderView()]
        
        return section
    }
    
    //MARK: - Create HeaderView
    private func createHeaderView() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80))
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                           elementKind: UICollectionView.elementKindSectionHeader,
                                                           alignment: .top)
    }
}

//MARK: - CollectionView Delegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath) else {
            collectionView.deselectItem(at: indexPath, animated: true)
            return
        }
        let detailVC = DetailViewController(movie: selectedItem)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
