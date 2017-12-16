//
//  CustomTabBarController.swift
//  Facebook
//
//  Created by Dai Tran on 12/8/17.
//  Copyright © 2017 Dai Tran. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let newsFeedCollectionViewController = NewsFeedCollectionViewController(collectionViewLayout: collectionViewLayout)
        let newsFeedNav = UINavigationController(rootViewController: newsFeedCollectionViewController)
        //newsFeedNav.navigationBar.barTintColor = UIColor(red: 51/255, green: 90/255, blue: 149/255, alpha: 1)
        newsFeedNav.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        newsFeedNav.tabBarItem.image = UIImage(named: "news_feed_icon")
        newsFeedNav.tabBarItem.title = "News"

        let friendRequestsVC = UIViewController()
        friendRequestsVC.navigationItem.title = "Friend Requests"
        let friendRequestsNav = UINavigationController(rootViewController: friendRequestsVC)
        friendRequestsNav.tabBarItem.title = "Friends"
        friendRequestsNav.tabBarItem.image = UIImage(named: "requests_icon")
        friendRequestsNav.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        let notificationsVC = UIViewController()
        notificationsVC.navigationItem.title = "Notifications"
        let notificationsNav = UINavigationController(rootViewController: notificationsVC)
        notificationsNav.tabBarItem.title = "Notifications"
        notificationsNav.tabBarItem.image = UIImage(named: "globe_icon")
        notificationsNav.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        let moreVC = UIViewController()
        moreVC.navigationItem.title = "Settings"
        let moreNav = UINavigationController(rootViewController: moreVC)
        moreNav.tabBarItem.title = "More"
        moreNav.tabBarItem.image = UIImage(named: "more_icon")
        moreNav.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        viewControllers = [newsFeedNav, friendRequestsNav, notificationsNav, moreNav]
        
        tabBar.isTranslucent = false
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = UIColor.rgb(red: 229, green: 231, blue: 235).cgColor
        
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
    }
}
