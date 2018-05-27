//
//  ViewController.swift
//  testSQL
//
//  Created by Olteanu Andrei on 21/05/2018.
//  Copyright © 2018 Olteanu Andrei. All rights reserved.
//

import UIKit
import OHMySQL

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let query = OHMySQLQueryRequestFactory.select("User", condition: nil)
        let response = try? OHMySQLContainer.shared.mainQueryContext?.executeQueryRequestAndFetchResult(query)
        print(response)
    }
}

