//
//  RootFlowController.swift
//  Eventerr
//
//  Created by Andrei Olteanu on 09/03/2018.
//  Copyright © 2018 Andrei Olteanu. All rights reserved.
//

import UIKit

class RootFlowController {
    
    private let window: UIWindow?
    private var homeFlowController: HomeFlowController?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
     
        homeFlowController = HomeFlowController()
        homeFlowController?.start()
        window?.rootViewController = homeFlowController?.rootViewController()
    }
}
