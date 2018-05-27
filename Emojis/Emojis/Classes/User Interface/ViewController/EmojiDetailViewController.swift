//
//  EmojiDetailViewController.swift
//  Eventerr
//
//  Created by Andrei Olteanu on 10/03/2018.
//  Copyright © 2018 Andrei Olteanu. All rights reserved.
//

import UIKit

class EmojiDetailViewController: UIViewController {
    
    private let closeBtn = UIButton()
    private let tableView = UITableView()
    private var bottomAnchor: NSLayoutConstraint!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        
        self.view.backgroundColor = .clear

        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor = tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomAnchor.isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)

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
