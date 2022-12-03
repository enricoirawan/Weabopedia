//
//  SearchViewController.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 03/12/22.
//

import UIKit
import SkeletonView
import Combine

class SearchViewController: UIViewController {
    // MARK: - Properties
    var searchAnimeUseCase: SearchAnimeUseCase?
    private var cancellables: Set<AnyCancellable> = []
    private var result: [Anime]?
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search anime"
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 6
        textField.layer.borderColor = UIColor.systemOrange.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.leftViewMode = .always
        textField.keyboardType = .default
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .systemOrange
        button.layer.borderColor = UIColor.systemOrange.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 6
        return button
    }()
    
    private let searchResultTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.isSkeletonable = true
        table.showsVerticalScrollIndicator = false
        table.register(AnimeTableViewCell.self, forCellReuseIdentifier: AnimeTableViewCell.identifier)
        return table
    }()
    
    private let notFoundLabel: UILabel = {
        let label = UILabel()
        label.text = "Not found T_T"
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        return label
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Search"
        navigationController?.navigationBar.tintColor = UIColor.systemOrange
        
        configureUI()
    }
    
    // MARK: - Selector
    @objc private func handleSearch() {
        guard let query = searchTextField.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3 else {
            let alert = UIAlertController(title: "Alert", message: "Keyword must contain at least three characters.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        searchAnime(withQuery: query)
    }
    
    // MARK: - Helper
    private func configureUI() {
        view.addSubview(searchTextField)
        searchTextField.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            height: 60
        )
        
        view.addSubview(searchButton)
        searchButton.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: searchTextField.trailingAnchor,
            trailing: view.trailingAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingRight: 10,
            width: 60,
            height: 60
        )
        searchButton.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        
        view.addSubview(searchResultTableView)
        searchResultTableView.anchor(
            top: searchTextField.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingRight: 10
        )
        searchResultTableView.dataSource = self
        searchResultTableView.delegate = self
    }
    
    private func searchAnime(withQuery query: String) {
        searchResultTableView.showSkeleton(usingColor: .silver, transition: .crossDissolve(0.25))
        searchAnimeUseCase?.execute(withQuery: query)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    let alert = UIAlertController(title: "Alert", message: String(describing: completion), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                case .finished:
                    guard let result = self.result else { return }
                    
                    if result.isEmpty {
                        self.searchResultTableView.backgroundView = self.notFoundLabel
                        return
                    }
                    self.searchResultTableView.hideSkeleton(reloadDataAfter: true)
                }
            }, receiveValue: { animeList in
                self.result = animeList
            })
            .store(in: &cancellables)
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnimeTableViewCell.identifier, for: indexPath) as? AnimeTableViewCell else {
            return UITableViewCell()
        }
        
        guard let result = result else {
            return UITableViewCell()
        }
        let anime = result[indexPath.row]
        cell.configure(with: anime)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
