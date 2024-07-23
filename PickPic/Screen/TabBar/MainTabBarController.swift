//
//  MainTabBarController.swift
//  PickPic
//
//  Created by 여성은 on 7/22/24.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tabBar.tintColor = Color.mainColor
//        tabBar.unselectedItemTintColor = Color.lightgray
        
        let topic = TopicViewController()
        let nav1 = UINavigationController(rootViewController: topic)
        nav1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "chart.xyaxis.line"), tag: 0)
        
        let search = SearchViewController()
        let nav2 = UINavigationController(rootViewController: search)
        nav2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        let like = LikeViewController()
        let nav3 = UINavigationController(rootViewController: like)
        nav3.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart"), tag: 2)
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }
}
