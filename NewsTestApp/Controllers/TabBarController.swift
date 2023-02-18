//
//  TabBarController.swift
//  NewsTestApp
//
//  Created by Dmitry Gorbunow on 2/19/23.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        view.backgroundColor = .systemBackground
        setUpTabs()
        tabBar.tintColor = UIColor(red: CGFloat(117/255.0), green: CGFloat(146/255.0), blue: CGFloat(221/255.0), alpha: CGFloat(1.0))
        tabBar.backgroundColor = UIColor(red: CGFloat(249/255.0), green: CGFloat(249/255.0), blue: CGFloat(249/255.0), alpha: CGFloat(0.94))
        tabBar.layer.borderWidth = 0.50
        tabBar.layer.borderColor = UIColor(red: CGFloat(134/255.0), green: CGFloat(134/255.0), blue: CGFloat(138/255.0), alpha: CGFloat(1)).cgColor
    }
    
    private func setUpTabs() {
        let newsVC = NewsViewController()
        let mapVC = MapViewController()
        let favoriteVC = FavoriteViewController()
        let profileVC = ProfileViewController()
        
        newsVC.navigationItem.largeTitleDisplayMode = .automatic
        mapVC.navigationItem.largeTitleDisplayMode = .automatic
        favoriteVC.navigationItem.largeTitleDisplayMode = .automatic
        profileVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: newsVC)
        let nav2 = UINavigationController(rootViewController: mapVC)
        let nav3 = UINavigationController(rootViewController: favoriteVC)
        let nav4 = UINavigationController(rootViewController: profileVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Новости",
                                       image: UIImage(named: "newsIcon"),
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Карта",
                                       image: UIImage(named: "mapIcon"),
                                       tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Избранное",
                                       image: UIImage(named: "FavoriteIcon"),
                                       tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Профиль",
                                       image: UIImage(named: "profileIcon"),
                                       tag: 4)
        
        for nav in [nav1, nav2, nav3, nav4] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(
            [nav1, nav2, nav3, nav4],
            animated: true
        )
    }
}
