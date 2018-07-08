//
//  GotPagedViewController.swift
//  GotPaged
//
//  Created by Olteanu Andrei on 07/07/2018.
//  Copyright © 2018 Olteanu Andrei. All rights reserved.
//

import UIKit

private enum Direction: Int {
    case neutral = 0
    case forward = 1
    case backwards = -1
}

class GotPagedViewController: UIPageViewController {

    // MARK: - Private Properties


    /// Start offset of the scroll view
    private var startOffset: CGFloat = 0

    /// All the viewControllers passed in the pageViewController
    private let orderedViewControllers: [UIViewController]

    /// Current direction
    private var direction: Direction = Direction.neutral

    /// Scroll Percent is always updating
    private var scrollPercent: CGFloat = 0

    // MARK: - Lifecycle

    init(viewControllers: [UIViewController]) {
        self.orderedViewControllers = viewControllers
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.subviews.forEach { if let view = $0 as? UIScrollView { view.delegate = self } }
        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
}

// MARK: - UIPageViewControllerDataSource

extension GotPagedViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else { return nil }
        guard orderedViewControllers.count > previousIndex else { return nil }
        return orderedViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1

        guard orderedViewControllers.count > nextIndex else { return nil }
        guard orderedViewControllers.count != nextIndex else { return nil }
        return orderedViewControllers[nextIndex]
    }
}

// MARK: - UIPageViewControllerDataSource

extension GotPagedViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffset = scrollView.contentOffset.x
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        direction = .neutral

        if startOffset < offsetX { direction = .forward }
        if startOffset > offsetX { direction = .backwards }

        let positionFromStartOfCurrentPage = abs(startOffset - offsetX)
        scrollPercent = positionFromStartOfCurrentPage /  view.frame.width
        print(scrollPercent)
    }
}
