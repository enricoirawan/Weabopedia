//
//  DetailViewController.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 02/12/22.
//

import UIKit
import Combine
import SkeletonView

enum Sections: Int {
    case Episode = 0
    case Duration = 1
    case Aired = 2
    case Genre = 3
    case Season = 4
    case Studio = 5
    case Synopsis = 6
}

class DetailViewController: UIViewController {
    // MARK: - Properties
    var getAnimeDetailUseCase: GetAnimeDetailUseCase?
    private var cancellables: Set<AnyCancellable> = []
    private var detail: Anime?
    private var animeId: Int?
    
    private let detailCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isSkeletonable = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(
            DetailHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: DetailHeaderView.identifier
        )
        collectionView.register(
            SynopsisCollectionViewCell.self,
            forCellWithReuseIdentifier: SynopsisCollectionViewCell.identifier
        )
        collectionView.register(
            GenreDetailCollectionViewCell.self,
            forCellWithReuseIdentifier: GenreDetailCollectionViewCell.identifier
        )
        collectionView.register(
            EpisodeCollectionViewCell.self,
            forCellWithReuseIdentifier: EpisodeCollectionViewCell.identifier
        )
        collectionView.register(
            DurationCollectionViewCell.self,
            forCellWithReuseIdentifier: DurationCollectionViewCell.identifier
        )
        collectionView.register(
            AiredCollectionViewCell.self,
            forCellWithReuseIdentifier: AiredCollectionViewCell.identifier
        )
        collectionView.register(
            SeasonCollectionViewCell.self,
            forCellWithReuseIdentifier: SeasonCollectionViewCell.identifier
        )
        collectionView.register(
            StudioCollectionViewCell.self,
            forCellWithReuseIdentifier: StudioCollectionViewCell.identifier
        )
        return collectionView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.tabBarController?.tabBar.isHidden = true
        
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(goback), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
        configureUI()
        getAnimeDetail()
    }
    
    // MARK: - Selector
    @objc private func goback() {
        dismiss(animated: true)
    }
    
    // MARK: - Helper
    private func configureUI() {
        view.addSubview(detailCollectionView)
        detailCollectionView.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor
        )
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
    }
    
    private func getAnimeDetail() {
        guard let animeId = animeId else { return }
        getAnimeDetailUseCase?.execute(withAnimeId: animeId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    let alert = UIAlertController(title: "Alert", message: String(describing: completion), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                case .finished:
                    self.detailCollectionView.reloadData()
                }
            }, receiveValue: { anime in
                self.detail = anime
            })
            .store(in: &cancellables)
    }
    
    func configure(withAnimeId id: Int) {
        animeId = id
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case Sections.Synopsis.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SynopsisCollectionViewCell.identifier, for: indexPath) as? SynopsisCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            if detail != nil {
                cell.configure(with: detail!.synopsis)
            }
            return cell
        case Sections.Episode.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionViewCell.identifier, for: indexPath) as? EpisodeCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            if detail != nil {
                cell.configure(with: detail!.episodes)
            }
            return cell
        case Sections.Duration.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DurationCollectionViewCell.identifier, for: indexPath) as? DurationCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            if detail != nil {
                cell.configure(with: detail!.duration)
            }
            return cell
        case Sections.Genre.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreDetailCollectionViewCell.identifier, for: indexPath) as? GenreDetailCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            if detail != nil {
                cell.configure(with: detail!.genres)
            }
            return cell
        case Sections.Aired.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AiredCollectionViewCell.identifier, for: indexPath) as? AiredCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            if detail != nil {
                cell.configure(with: detail!.aired, and: detail!.year)
            }
            return cell
        case Sections.Season.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeasonCollectionViewCell.identifier, for: indexPath) as? SeasonCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            if detail != nil {
                cell.configure(with: detail!.season)
            }
            return cell
        case Sections.Studio.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StudioCollectionViewCell.identifier, for: indexPath) as? StudioCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            if detail != nil {
                cell.configure(with: detail!.studios)
            }
            return cell
        default:
            fatalError("not implement")
        }
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailHeaderView.identifier, for: indexPath) as? DetailHeaderView else { return UICollectionReusableView() }
        
        if detail != nil {
            header.configure(with: detail!)
        }
        return header
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == Sections.Synopsis.rawValue {
            return CGSize(width: view.frame.width, height: 800)
        }
        
        return CGSize(width: view.frame.width, height: 70)
    }
}
