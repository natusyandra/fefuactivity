//
//  TabBarController.swift
//  fefuactivity
//
//  Created by Котик on 13.05.2022.
//

import UIKit


class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tabBar.tintColor = .label
        setupViewControllers()
    }
    
    func setupViewControllers() {
        viewControllers = [
            createNavController(for: ActivityViewController(), title: NSLocalizedString("Активности", comment: ""), image: UIImage(systemName: "circle")!),
            createNavController(for: ActivityViewController(), title: NSLocalizedString("Профиль", comment: ""), image: UIImage(systemName: "circle")!)
        ]
    }
    
    func createNavController(for rootViewController: UIViewController,
                             title: String,
                             image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        return navController
    }
}
