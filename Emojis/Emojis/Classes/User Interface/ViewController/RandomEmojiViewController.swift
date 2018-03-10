//
//  RandomEmojiViewController.swift
//  Eventerr
//
//  Created by Andrei Olteanu on 09/03/2018.
//  Copyright © 2018 Andrei Olteanu. All rights reserved.
//

import UIKit

protocol RandomEmojiFlowDelegate: class {
    func presentSomeModal(on viewController: RandomEmojiViewController)
}

class RandomEmojiViewController: UIViewController {
    
    var emojiLbl: UILabel!
    var titleLbl: UILabel!
    var emojiIndex = 0
    var flowDelegate: RandomEmojiFlowDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTapGestures()
        setAndRepeatEmoji()
    }

    
    func setupViews() {
        
        self.view.backgroundColor = .black
        
        // The emoji label
        emojiLbl = UILabel()
        emojiLbl.font = UIFont.systemFont(ofSize: 130)
        self.view.addSubview(emojiLbl)
        emojiLbl.translatesAutoresizingMaskIntoConstraints = false
        emojiLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        emojiLbl.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        emojiLbl.text = Service.emojis[0]
        
        // Title label
        titleLbl = UILabel()
        titleLbl.font = UIFont.boldSystemFont(ofSize: 34)
        self.view.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        titleLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.width / 5).isActive = true
        titleLbl.textColor = .white
        titleLbl.text = "Pick one emoji"
    }
    
    func setupTapGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
        tapGesture.numberOfTapsRequired = 1
        emojiLbl.isUserInteractionEnabled = true
        emojiLbl.addGestureRecognizer(tapGesture)
    }
    
    func setAndRepeatEmoji() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            
            if self.emojiIndex == Service.emojis.count - 1 {
                self.emojiIndex = 0
            } else {
                self.emojiIndex = self.emojiIndex + 1
            }
            
            self.emojiLbl.text = Service.emojis[self.emojiIndex]
            self.setAndRepeatEmoji()
        }
    }
    
    // Function triggered when handleTap is called
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("Hello Tapper")
        flowDelegate?.presentSomeModal(on: self)
    }
}







