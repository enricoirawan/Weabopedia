//
//  HomeViewController.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 30/11/22.
//

import UIKit
import Combine
import SkeletonView

class HomeViewController: UIViewController {
    // MARK: - Properties
    var getListAnimeUseCase: GetListAnimeUseCase?
    var getListGenreUseCase: GetListGenreUseCase?
    private var cancellables: Set<AnyCancellable> = []
    private var genreList: [Genre]?
    private var animeList: [Anime]?
    
    private let appTitle: UILabel = {
        let label = UILabel()
        let atrributedTitle = NSMutableAttributedString(string: "Weabo", attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40),
            NSAttributedString.Key.foregroundColor: UIColor.systemOrange
        ])
        atrributedTitle.append(NSAttributedString(string: "pedia", attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]))
        label.attributedText = atrributedTitle
        return label
    }()
    
    private let genreCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isSkeletonable = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureUI()
        loadGenre()
        loadAnime()
    }
    
    // MARK: - Selector
    
    // MARK: - Helper
    private func configureUI() {
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(appTitle)
        appTitle.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            paddingTop: 16,
            paddingLeft: 16
        )
        
        view.addSubview(genreCollectionView)
        genreCollectionView.dataSource = self
        genreCollectionView.delegate = self
        genreCollectionView.anchor(
            top: appTitle.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            paddingTop: 10,
            height: 50
        )
    }
    
    private func loadGenre() {
        genreCollectionView.showSkeleton(usingColor: .silver, transition: .crossDissolve(0.25))
        getListGenreUseCase?.execute()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error \(error.localizedDescription)")
                    print("\(String(describing: completion))")
                case .finished:
                    self.genreCollectionView.hideSkeleton(reloadDataAfter: true)
                }
            }, receiveValue: { [weak self] genreList in
                self?.genreList = genreList
            })
            .store(in: &cancellables)
    }
    
    private func loadAnime() {
        getListAnimeUseCase?.execute(withGenreId: 1)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error \(error.localizedDescription)")
                    print("\(String(describing: completion))")
                case .finished:
                    print("Finished")
                }
            }, receiveValue: { [weak self] animeList in
                self?.animeList = animeList
            })
            .store(in: &cancellables)
    }
}

extension HomeViewController: SkeletonCollectionViewDataSource, SkeletonCollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - SkeletonCollectionViewDataSource
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return GenreCollectionViewCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let genres = genreList else { return 0 }
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GenreCollectionViewCell.identifier,
            for: indexPath
        ) as? GenreCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // pre-select when collection views appear
        if indexPath.row == 0 {
            genreCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            cell.isSelected = true
        }
        
        guard let genres = genreList else { return UICollectionViewCell() }
        let genre = genres[indexPath.row]
        cell.configure(with: genre)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let genreList = genreList else { return }
        let selectedGenre = genreList[indexPath.row]
        print(selectedGenre)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 50)
    }
}
