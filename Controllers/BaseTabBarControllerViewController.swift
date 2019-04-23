//
//  BaseTabBarControllerViewController.swift
//  appStore
//
//  Created by Alex Beattie on 4/22/19.
//  Copyright © 2019 Alex Beattie. All rights reserved.
//

import UIKit

class BaseTabBarControllerViewController: UITabBarController {
 
    // 1 - create Today controller
    // 2 - refactor our repeated logic inside of viewDidLoad
    // 3 - introduce AppSearchController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        viewControllers = [
            createNavController(viewController: AppSearchController(), title: "Search", imageName: "search"),
            createNavController(viewController: UIViewController(), title: "Today", imageName: "today_icon"),
            createNavController(viewController: UIViewController(), title: "Apps", imageName: "apps"),
            
        ]
        
    }

    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        
    
        return navController
    }
}
