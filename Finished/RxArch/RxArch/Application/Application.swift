//
//  Application.swift
//  RxArch
//
//  Created by Albert Gil Escura on 17-06-19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import UIKit

final class Application {
    
    // MARK: Public Methods
    
    func start(with window: UIWindow) {
        let tabBarController = UITabBarController()
        let useCase = UseCase(alamofire: AlamofireProvider(service: AlamofireService()),
                              realm: RealmProvider(service: RealmService()),
                              reachability: ReachabilityProvider(service: ReachabilityService()))
    
        tabBarController.viewControllers = [
            builder(useCase,
                    using: .internet,
                    with: UITabBarItem.init(title: "Download", image: #imageLiteral(resourceName: "download"), tag: 0)),
            builder(useCase,
                    using: .completed,
                    with: UITabBarItem.init(title: "Completed", image: #imageLiteral(resourceName: "completed"), tag: 1)),
            builder(useCase,
                    using: .incompleted,
                    with: UITabBarItem.init(title: "Incompleted", image: #imageLiteral(resourceName: "incompleted"), tag: 2)),
        ]
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    // MARK: Private Methods
    
    private func builder(_ useCase: UseCase, using type: TodoType, with item: UITabBarItem) -> UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let listNavigation = storyboard.instantiateViewController(withIdentifier: "ListViewController") as! UINavigationController
        listNavigation.tabBarItem = item
        let listViewController = listNavigation.viewControllers.first as! ListViewController
        listViewController.viewModel = ListViewModel(type: type, useCase: useCase)
        return listNavigation
    }
}
