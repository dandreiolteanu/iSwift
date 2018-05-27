//
//  SecondViewController.swift
//  dragTableView
//
//  Created by Olteanu Andrei on 10/05/2018.
//  Copyright © 2018 Olteanu Andrei. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    let treshold: CGFloat = 250
    var dragging = false
    var previousContentOffsetY: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .blue
        return cell
    }
}

extension SecondViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension SecondViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if dragging {
            let diff = scrollView.contentOffset.y - previousContentOffsetY
            print(scrollView.contentOffset.y)
            if scrollView.contentOffset.y < -scrollView.contentInset.top || bottom.constant < 0 {
                updateViewPosition(offset: diff)
                scrollView.contentOffset.y = -scrollView.contentInset.top
            }
            previousContentOffsetY = scrollView.contentOffset.y
        }
    }


    func updateViewPosition(offset: CGFloat) {
        bottom.constant = bottom.constant + offset
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        dragging = true
        previousContentOffsetY = scrollView.contentOffset.y
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        dragging = false
        previousContentOffsetY = 0.0
        if -bottom.constant > treshold {
            self.dismiss(animated: true, completion: nil)
        } else {
            bottom.constant = 0.0
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: velocity.y, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
}
