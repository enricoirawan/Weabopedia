//
//  DetailHeaderView.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 02/12/22.
//

import UIKit
import SDWebImage

class DetailHeaderView: UICollectionReusableView {
    static let identifier = "DetailHeaderView"
    
    // MARK: - Properties
    private var anime: Anime?
    
    private let poster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.numberOfLines = 2
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let titleEnglish: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 2
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let scoreIcon: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "star.fill")
        imageView.image = image
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    private let scoreDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let scoreContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }()
    
    private let rating: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 2
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let status: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 1
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setTitle("Add to favorite", for: .normal)
        button.tintColor = .systemOrange
        button.backgroundColor = .white
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(favoriteHandler), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemOrange
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selector
    @objc private func favoriteHandler() {
        print("Tapped")
    }
    
    // MARK: - Helper
    private func configureUI() {
        addSubview(poster)
        poster.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            leading: leadingAnchor,
            paddingTop: 20,
            paddingLeft: 10,
            width: 150,
            height: 220
        )
        
        addSubview(title)
        title.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            leading: poster.trailingAnchor,
            trailing: trailingAnchor,
            paddingTop: 20,
            paddingLeft: 10,
            paddingBottom: 10,
            paddingRight: 10
        )
        
        addSubview(titleEnglish)
        titleEnglish.anchor(
            top: title.bottomAnchor,
            leading: poster.trailingAnchor,
            trailing: trailingAnchor,
            paddingLeft: 10,
            paddingRight: 10
        )
        
        addSubview(rating)
        rating.anchor(
            top: titleEnglish.bottomAnchor,
            leading: poster.trailingAnchor,
            trailing: trailingAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingRight: 10
        )
        
        addSubview(status)
        status.anchor(
            top: rating.bottomAnchor,
            leading: poster.trailingAnchor,
            trailing: trailingAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingRight: 10
        )
        
        addSubview(scoreContainer)
        scoreContainer.addArrangedSubview(scoreIcon)
        scoreContainer.addArrangedSubview(scoreDescription)
        scoreContainer.anchor(
            top: status.bottomAnchor,
            leading: poster.trailingAnchor,
            trailing: trailingAnchor,
            paddingLeft: 10,
            paddingRight: 10
        )
        
        addSubview(favoriteButton)
        favoriteButton.anchor(
            top: scoreContainer.bottomAnchor,
            leading: poster.trailingAnchor,
            bottom: poster.bottomAnchor,
            trailing: trailingAnchor,
            paddingLeft: 10,
            paddingRight: 10,
            height: 40
        )
    }
    
    func configure(with anime: Anime) {
        self.anime = anime
        guard let url = URL(string: anime.images.jpg.imageURL) else {return}
        poster.sd_setImage(with: url, completed: nil)
        
        title.text = "(\(anime.type)) \(anime.title)"
        titleEnglish.text = "English: (\(anime.titleEnglish))"
        status.text = anime.status
        rating.text = anime.rating
        
        let atrributedScoreDescription = NSMutableAttributedString(string: "\(anime.score)", attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        atrributedScoreDescription.append(NSAttributedString(string: " (\(anime.scoredBy) votes)", attributes: [
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]))
        scoreDescription.attributedText = atrributedScoreDescription
    }
}
