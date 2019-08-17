//
//  CustomTabBarController.swift
//  STTwitterDebounceDemo
//
//  Created by Vinicius Mangueira on 10/08/19.
//  Copyright © 2019 Vinicius Mangueira . All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    fileprivate func setupTabBar() {
        viewControllers = [createNavigation(viewController: ViewController(), title: "Home", imageNamed: "home"),createNavigation(viewController: ViewController(), title: "Search", imageNamed: "search"),createNavigation(viewController: ViewController(), title: "Notification", imageNamed: "notification"),createNavigation(viewController: ViewController(), title: "Messages", imageNamed: "email"),]
    }
    
    fileprivate func createNavigation(viewController: UIViewController, title: String,imageNamed: String) -> UINavigationController{
        let navigation = UINavigationController(rootViewController: viewController)
        viewController.navigationItem.title = title
        viewController.tabBarItem.title = title
        navigation.navigationBar.prefersLargeTitles = true
        viewController.tabBarItem.image = UIImage(named: imageNamed)
        return navigation
    }
    
}
