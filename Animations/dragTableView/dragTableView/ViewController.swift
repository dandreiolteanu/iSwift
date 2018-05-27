//
//  ViewController.swift
//  dragTableView
//
//  Created by Olteanu Andrei on 10/05/2018.
//  Copyright © 2018 Olteanu Andrei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func perssed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "second") as! SecondViewController
        secondViewController.modalPresentationStyle = .overCurrentContext
        self.present(secondViewController, animated: true, completion: nil)
    }
}
