//
//  SqueezyButton.swift
//  RevolutButton
//
//  Created by Olteanu Andrei on 08/07/2018.
//  Copyright © 2018 Olteanu Andrei. All rights reserved.
//

import UIKit

internal enum SelectorStateType {
    case touchDragInside
    case touchDragOutside
    case initial
}

@IBDesignable
class SqueezyButton: UIButton {

    // MARK: - Lifecycle

    /// Default Accent Color
    private var accentColor = #colorLiteral(red: 1, green: 0.2823529412, blue: 0.3450980392, alpha: 1)
    private var animationDuration: TimeInterval = 0.25
    private var selectorState: SelectorStateType = .initial

    /// Default Shadow Offset
    @IBInspectable
    public var shadowOffset: CGSize = CGSize(width: 0, height: 8) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }

    @IBInspectable
    public var shadowRadius: CGFloat = 6.5 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }

    @IBInspectable
    public var shadowOpacity: Float = 0.55 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }


    override var backgroundColor: UIColor? {
        didSet {
            layer.shadowColor = accentColor.cgColor
        }
    }

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }

    // MARK: - Private Methods

    private func setupView() {
        backgroundColor = accentColor
        setTitle("Done", for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        setTitleColor(.white, for: .normal)

        layer.shadowColor = accentColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity

        addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        addTarget(self, action: #selector(touchDragOutside), for: .touchDragOutside)
        addTarget(self, action: #selector(touchDragInside), for: .touchDragInside)
    }

   @objc private func touchUpInside() {
        selectorState = .touchDragOutside
        animate(dragInside: false)
    }

    @objc private func touchDragInside() {
        if selectorState != .touchDragInside {
            selectorState = .touchDragInside
            animate(dragInside: true)
        }
    }

   @objc private func touchDragOutside() {
        if selectorState != .touchDragOutside {
            selectorState = .touchDragOutside
            animate(dragInside: false)
        }
    }

    // MARK: - Animations

    private func animate(dragInside: Bool) {
        UIView.animate(withDuration: animationDuration) {
            self.transform = dragInside ? CGAffineTransform.init(scaleX: 0.99, y: 0.99) :  CGAffineTransform.identity
            self.alpha = dragInside ? 0.7 : 1.0
        }
    }
}
