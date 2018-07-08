//
//  WeekViewController.swift
//  GotPaged
//
//  Created by Olteanu Andrei on 07/07/2018.
//  Copyright © 2018 Olteanu Andrei. All rights reserved.
//

import UIKit

class WeekViewController: BaseViewController {

    // MARK: - Private Properties

    private let weekDay: WeekDay

    private let colors = [#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), #colorLiteral(red: 1, green: 0.2823529412, blue: 0.3450980392, alpha: 1), #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)]
    private let dayLabel = UILabel()

    // MARK: - Lifecycle

    init(weekDay: WeekDay) {
        self.weekDay = weekDay
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }

    private func setupView() {
        view.backgroundColor = colors.randomElement()

        dayLabel.text = weekDay.string
        dayLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        dayLabel.textColor = .white
        view.addSubview(dayLabel)
    }

    private func setupConstraints() {
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dayLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
