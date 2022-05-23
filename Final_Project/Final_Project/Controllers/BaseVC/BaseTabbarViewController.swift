//
//  BaseTabbarViewController.swift
//  Final_Project
//
//  Created by tri.nguyen on 17/05/2022.
//

import UIKit

class BaseTabbarViewController: UITabBarController {

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabbarView()
    }
    
    // MARK: - ConfigUI
    func configTabbarView() {
        // News
        let newsVC = NewsViewController()
        let newsNav = UINavigationController(rootViewController: newsVC)
        newsNav.tabBarItem = UITabBarItem(title: "Top Stories", image: UIImage(systemName: "flame.fill"), tag: 0)
        
        // Search
        let searchVC = SearchViewController()
        let searchNav = UINavigationController(rootViewController: searchVC)
        searchNav.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        // MyNews
        let myNewsVC = MyNewsViewController()
        let myNewsNav = UINavigationController(rootViewController: myNewsVC)
        myNewsNav.tabBarItem = UITabBarItem(title: "MyNews", image: UIImage(systemName: "person.text.rectangle.fill"), tag: 2)
        
        // Tabbar
        self.viewControllers = [newsNav, searchNav, myNewsNav]
        self.tabBar.tintColor = .white
        self.tabBar.barTintColor =  UIColor(red: 135/255, green: 206/255, blue: 250/255, alpha: 1.0)
        self.tabBar.backgroundColor =  UIColor(red: 135/255, green: 206/255, blue: 250/255, alpha: 1.0)
    }
}
