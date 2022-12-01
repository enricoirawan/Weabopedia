//
//  BaseViewController.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 30/11/22.
//

import UIKit

class BaseViewController: UITabBarController {
    // MARK: - Properties
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomNav()
    }
    
    private func setupBottomNav() {
        let homeImage = UIImage(systemName: "house")
        let homeVC = Injection().container.resolve(HomeViewController.self)
        let home = templateNavigationController(image: homeImage, rootViewController: homeVC!, title: "Home")
        
        let favoriteImage = UIImage(systemName: "heart")
        let favorite = templateNavigationController(image: favoriteImage, rootViewController: FavoriteViewController(), title: "Favorite")
        
        viewControllers = [home, favorite]
    }
    
    // MARK: - Helper
    private func templateNavigationController(image: UIImage?, rootViewController: UIViewController, title: String) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        nav.navigationBar.tintColor = .white
        
        tabBar.tintColor = .systemOrange
        tabBar.backgroundColor = .systemBackground
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 2
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
        return nav
    }
}
