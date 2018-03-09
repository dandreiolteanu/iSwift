//
//  RandomEmojiFlowController.swift
//  Eventerr
//
//  Created by Andrei Olteanu on 09/03/2018.
//  Copyright © 2018 Andrei Olteanu. All rights reserved.
//

import UIKit

class RandomEmojiFlowController {
    
    var randomEmojiViewController: RandomEmojiViewController!
    
    func start() {
        randomEmojiViewController = RandomEmojiViewController()
        randomEmojiViewController.flowDelegate = self
    }
    
    func rootViewController() -> UIViewController {
        return randomEmojiViewController
    }
}

extension RandomEmojiFlowController: RandomEmojiFlowDelegate {
    func presentSomeModal(on viewController: RandomEmojiViewController) {
        let someModal = EmojiDetailViewController()
        rootViewController().present(someModal, animated: true, completion: nil)
    }
    
    
}


