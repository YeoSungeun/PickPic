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
        
        tabBar.tintColor = Constant.Color.black
        
        let topic = TopicViewController()
        let nav1 = UINavigationController(rootViewController: topic)
        nav1.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tap_trend_inactive"), selectedImage: UIImage(named: "tap_trend"))
        
        let search = SearchViewController()
        let nav2 = UINavigationController(rootViewController: search)
        nav2.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tab_search_inactive"), selectedImage: UIImage(named: "tab_search"))
        
        let like = LikeViewController()
        let nav3 = UINavigationController(rootViewController: like)
        nav3.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tab_like_inactive"), selectedImage: UIImage(named: "tab_like"))
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }
}
