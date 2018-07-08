//
//  BaseViewController.swift
//  GotPaged
//
//  Created by Olteanu Andrei on 07/07/2018.
//  Copyright © 2018 Olteanu Andrei. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
