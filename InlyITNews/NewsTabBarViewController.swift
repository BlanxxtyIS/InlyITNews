//
//  TabBarViewController.swift
//  InlyITNews
//
//  Created by Марат Хасанов on 02.05.2024.
//

import UIKit

class NewsTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTabBar()
    }
    
    private func setupTabBar() {
        let mainViewController = MainNewsViewController()
        let mainNavigationViewController = UINavigationController(rootViewController: mainViewController)
        mainNavigationViewController.tabBarItem = UITabBarItem(title: "Новости",
                                                               image: UIImage(systemName: "doc.text.below.ecg.rtl"),
                                                               tag: 0)
        
        let favoriteViewController = FavoriteNewsViewController()
        let favoriteNavigationViewController = UINavigationController(rootViewController: favoriteViewController)
        favoriteNavigationViewController.tabBarItem = UITabBarItem(title: "Избранное",
                                                         image: UIImage(systemName: "star"),
                                                         tag: 1)
        
        viewControllers = [mainNavigationViewController, favoriteNavigationViewController]
    }
}
