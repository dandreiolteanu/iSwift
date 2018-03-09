//
//  HelloViewController.swift
//  Eventerr
//
//  Created by Andrei Olteanu on 09/03/2018.
//  Copyright © 2018 Andrei Olteanu. All rights reserved.
//

import UIKit

protocol HelloFlowDelegate: class {
    func wave(on viewController: HelloViewController)
}

class HelloViewController: UIViewController {
    
    weak var flowDelegate: HelloFlowDelegate?
    private var helloLbl: UILabel!
    private var waveEmojiLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTapGestures()
    }

    func setupViews() {
        
        self.view.backgroundColor = .black
        self.navigationItem.title = "Home"
        
        self.tabBarItem = UITabBarItem(title: "Wave", image: UIImage(named: "wave_notselected"), tag: 0)
        self.tabBarItem.selectedImage = UIImage(named: "wave_selected")
        
        // Hello Label
        helloLbl = UILabel()
        self.view.addSubview(helloLbl)
        helloLbl.text = "Hi There"
        helloLbl.font = UIFont.boldSystemFont(ofSize: 40)
        helloLbl.textColor = .white
        helloLbl.translatesAutoresizingMaskIntoConstraints = false
        helloLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        helloLbl.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        
        // Wave Emoji Label
        waveEmojiLbl = UILabel()
        self.view.addSubview(waveEmojiLbl)
        waveEmojiLbl.translatesAutoresizingMaskIntoConstraints = false
        waveEmojiLbl.text = "👋"
        waveEmojiLbl.font = UIFont.systemFont(ofSize: 80)
        waveEmojiLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        waveEmojiLbl.topAnchor.constraint(equalTo: helloLbl.bottomAnchor, constant: 30).isActive = true
        
    }
    
    func setupTapGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
        tapGesture.numberOfTapsRequired = 1
        waveEmojiLbl.isUserInteractionEnabled = true
        waveEmojiLbl.addGestureRecognizer(tapGesture)
    }
    
    // function which is triggered when handleTap is called
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("Hello Tapper")
        flowDelegate?.wave(on: self)
    }

}
