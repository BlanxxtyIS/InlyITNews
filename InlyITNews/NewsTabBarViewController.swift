//
//  TabBarViewController.swift
//  InlyITNews
//
//  Created by Марат Хасанов on 02.05.2024.
//

import UIKit

final class NewsTabBarController: UITabBarController {

    // MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .black
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
        setupTabBar()
    }
    
    // MARK: - Private Methods
    private func setupTabBar() {
        let mainViewController = MainNewsViewController()
        let mainNavigationViewController = createNavController(for: mainViewController, title: "Новости", imageSystemName: "doc.text.below.ecg.rtl")
        
        let favoriteViewController = FavoriteNewsViewController()
        let favoriteNavigationViewController = createNavController(for: favoriteViewController,
                                                                   title: "Избранное",
                                                                   imageSystemName: "star")
        
        viewControllers = [mainNavigationViewController, favoriteNavigationViewController]
    }
    
    private func createNavController(for rootViewController: UIViewController, 
                                     title: String,
                                     imageSystemName: String) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem = UITabBarItem(title: title,
                                                        image: UIImage(systemName: imageSystemName),
                                                        tag: 0)
        return navigationController
    }
}
