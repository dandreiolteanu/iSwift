//
//  ViewController.swift
//  GotPaged
//
//  Created by Olteanu Andrei on 07/07/2018.
//  Copyright © 2018 Olteanu Andrei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var containerView = UIView()
    private var pageViewController: GotPagedViewController!

    private let viewControllers = [WeekViewController(weekDay: WeekDay.monday), WeekViewController(weekDay: WeekDay.tuesday),
                                   WeekViewController(weekDay: WeekDay.wednesday), WeekViewController(weekDay: WeekDay.thursday),
                                   WeekViewController(weekDay: WeekDay.friday), WeekViewController(weekDay: WeekDay.saturday),
                                   WeekViewController(weekDay: WeekDay.sunday)]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }

    private func setupView() {
        navigationItem.title = "Paged"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white

        // Container View
        pageViewController = GotPagedViewController(viewControllers: viewControllers)
        addChild(pageViewController)
        containerView = pageViewController.view
        view.addSubview(containerView)
    }

    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        pageViewController.didMove(toParent: self)
    }
}

