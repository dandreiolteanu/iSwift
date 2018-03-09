//
//  WelcomeViewController.swift
//  Eventerr
//
//  Created by Andrei Olteanu on 09/03/2018.
//  Copyright © 2018 Andrei Olteanu. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Welcome"

    }

    func setupViews() {
        
        self.view.backgroundColor = .white
    }
}
