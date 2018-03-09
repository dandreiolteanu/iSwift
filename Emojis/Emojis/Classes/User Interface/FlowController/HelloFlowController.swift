//
//  HelloFlowController.swift
//  Eventerr
//
//  Created by Andrei Olteanu on 09/03/2018.
//  Copyright © 2018 Andrei Olteanu. All rights reserved.
//

import UIKit

class HelloFlowController {
    
    var navigationController: CustomNavigationController!
    var helloViewController: HelloViewController!
    
    func start() {
        helloViewController = HelloViewController()
        helloViewController.flowDelegate = self
        navigationController = CustomNavigationController(rootViewController: helloViewController)
        navigationController.viewControllers = [helloViewController]
        navigationController.navigationBar.shadowImage = UIImage()
    }
    
    func rootViewController() -> CustomNavigationController {
        return navigationController
    }
}

extension HelloFlowController: HelloFlowDelegate {
    func wave(on viewController: HelloViewController) {
        let welcomeViewController = WelcomeViewController()
        navigationController.pushViewController(welcomeViewController, animated: true)
    }

}
    




