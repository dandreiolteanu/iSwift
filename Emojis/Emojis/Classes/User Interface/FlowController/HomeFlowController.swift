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

        randomEmojiFlowController = RandomEmojiFlowController()
        randomEmojiFlowController.start()
        
        let helloTabBarItem = UITabBarItem(title: "Hello", image: UIImage(named: "wave_selected"), tag: 0)
        helloFlowController.rootViewController().tabBarItem = helloTabBarItem
        let randomTabBarItem = UITabBarItem(title: "Random", image: UIImage(named: "random"), tag: 1)
        randomEmojiFlowController.rootViewController().tabBarItem = randomTabBarItem
        tabBarController.viewControllers = [helloFlowController.rootViewController(), randomEmojiFlowController.rootViewController()]
    }
    
    func rootViewController() -> UITabBarController {
        return tabBarController
    }
}
