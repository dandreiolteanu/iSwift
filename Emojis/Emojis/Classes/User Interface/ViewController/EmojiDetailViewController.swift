//
//  EmojiDetailViewController.swift
//  Eventerr
//
//  Created by Andrei Olteanu on 10/03/2018.
//  Copyright © 2018 Andrei Olteanu. All rights reserved.
//

import UIKit

class EmojiDetailViewController: UIViewController {
    
    var closeBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        
        self.view.backgroundColor = .black
        
        closeBtn = UIButton()
        closeBtn.addTarget(self, action: #selector(didTapCloseBtn(_:)), for: .touchUpInside)
        view.addSubview(closeBtn)
        closeBtn.setTitle("Dismiss", for: .normal)
        closeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        closeBtn.tintColor = .white
        closeBtn.translatesAutoresizingMaskIntoConstraints = false
        closeBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        closeBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
    }
    
    @objc func didTapCloseBtn(_ sender: UIButton) {
        print("Closing Emoji Detail View Controller")
        self.dismiss(animated: true, completion: nil)
    }
}
