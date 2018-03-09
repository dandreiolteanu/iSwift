//
//  HomeFlowController.swift
//  Eventerr
//
//  Created by Andrei Olteanu on 09/03/2018.
//  Copyright © 2018 Andrei Olteanu. All rights reserved.
//

import UIKit

class HomeFlowController {
    
    var tabBarController = HomeTabBarController()
    var helloFlowController: HelloFlowController!
    var randomEmojiFlowController: RandomEmojiFlowController!
    
    // MARK: - Lifecycle
    func start() {
        
        tabBarController.tabBar.tintColor = .white
        
        helloFlowController = HelloFlowController()
        helloFlowController.start()
        let helloRootNavigationController = helloFlowController.rootViewController()
        let helloTabBarItem = UITabBarItem(title: "Hello", image: UIImage(named: "wave_selected"), tag: 0)
        helloRootNavigationController.tabBarItem = helloTabBarItem
        
        randomEmojiFlowController = RandomEmojiFlowController()
        randomEmojiFlowController.start()
        let randomEmojiRootController = randomEmojiFlowController.rootViewController()
        let randomTabBarItem = UITabBarItem(title: "Random", image: UIImage(named: "random"), tag: 1)
        randomEmojiRootController.tabBarItem = randomTabBarItem
        
        
        tabBarController.viewControllers = [helloRootNavigationController, randomEmojiRootController]
    }
    
    func rootViewController() -> UITabBarController {
        return tabBarController
    }
}
