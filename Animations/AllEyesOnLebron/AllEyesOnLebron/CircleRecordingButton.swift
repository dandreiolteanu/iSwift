//
//  CircleRecordingView.swift
//  AllEyesOnLebron
//
//  Created by Olteanu Andrei on 26/05/2018.
//  Copyright © 2018 Olteanu Andrei. All rights reserved.
//

import UIKit

protocol CircleRecordingButtonDelegate: class {
    func didStartRecording()
    func didEndRecording()
}

enum CircleRecordingButtonState: Int {
    case recording, idle
}

private enum RecordingOptions {
    case starting
    case end
    case recordLessThanMinimumTimeSet
}

class CircleRecordingButton: UIButton {

    // MARK: - Public Properties

    weak var delegate: CircleRecordingButtonDelegate?

    var buttonColor: UIColor = .white
    var notRecordingButtonLineColor = #colorLiteral(red: 0.1019607843, green: 0.1607843137, blue: 0.3137254902, alpha: 1)
    var progressColor: UIColor = #colorLiteral(red: 0.7258265615, green: 0.7348735929, blue: 0.7801960111, alpha: 1)
    private var notRecordingButtonLineWidth: CGFloat = 2.5
    private let generator = UIImpactFeedbackGenerator(style: .medium)


    var buttonState: CircleRecordingButtonState = .idle {
        didSet {
            switch buttonState {
            case .recording:
                print("recording")
                setRecording(to: .starting)
            case .idle:
                print("idle mode")
                setProgress(0)
                setRecording(to: .end)
            }
        }
    }

    private var circleLayer: CALayer!
    private var circleBorder: CALayer!
    private var circleRecordingLayer: CALayer!
    private var progressLayer: CAShapeLayer!
    private var gradientMaskLayer: CAGradientLayer!
    private var currentProgress: CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(didTouchDown), for: .touchDown)
        self.addTarget(self, action: #selector(didTouchUp), for: .touchUpInside)
        self.addTarget(self, action: #selector(didTouchUp), for: .touchUpOutside)

        drawButton()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func drawButton() {
        backgroundColor = .clear
        layer.cornerRadius = frame.size.height / 2

        circleLayer = CALayer()
        circleLayer.backgroundColor = buttonColor.cgColor
        let circleSize: CGFloat = frame.size.width
        circleLayer.bounds = CGRect(x: 0, y: 0, width: circleSize, height: circleSize)
        circleLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        circleLayer.cornerRadius = circleSize / 2
        circleLayer.position = CGPoint(x: bounds.midX,y: bounds.midY)
        layer.insertSublayer(circleLayer, at: 0)

        circleBorder = CALayer()
        circleBorder.backgroundColor = UIColor.clear.cgColor
        let borderSize: CGFloat = frame.size.width - 20
        circleBorder.borderWidth = notRecordingButtonLineWidth
        circleBorder.borderColor = notRecordingButtonLineColor.cgColor
        circleBorder.bounds = CGRect(x: 0, y: 0, width: borderSize, height: borderSize)
        circleBorder.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        circleBorder.position = CGPoint(x: bounds.midX,y: bounds.midY)
        circleBorder.cornerRadius = borderSize / 2
        layer.insertSublayer(circleBorder, at: 1)

        let scalingValue =  0.2 * self.frame.size.height
        let startAngle: CGFloat = CGFloat(Double.pi) + CGFloat(Double.pi / 2)
        let endAngle: CGFloat = CGFloat(Double.pi) * 3 + CGFloat(Double.pi / 2)
        let centerPoint: CGPoint = CGPoint(x: 1.2 * self.frame.size.width / 2, y: 1.2 * self.frame.size.height / 2)
        gradientMaskLayer = createGradientMask()
        gradientMaskLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        progressLayer = CAShapeLayer()
        progressLayer.path = UIBezierPath(arcCenter: centerPoint, radius: self.frame.size.width / 2 + 4, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
        progressLayer.backgroundColor = UIColor.clear.cgColor
        progressLayer.fillColor = nil
        progressLayer.strokeColor = UIColor.black.cgColor
        progressLayer.lineWidth = frame.size.width / 2 + scalingValue
        progressLayer.strokeStart = 0.0
        progressLayer.strokeEnd = 0.0
        gradientMaskLayer.mask = progressLayer
        layer.insertSublayer(gradientMaskLayer, at: 2)
    }

    private func createGradientMask() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.frame.size.height = 1.2 * self.bounds.size.height
        gradientLayer.frame.size.width = 1.2 * self.bounds.size.width
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.cornerRadius = 1.2 * self.frame.size.height / 2
        let topColor = progressColor
        let bottomColor = progressColor
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        return gradientLayer
    }

    @objc open func didTouchDown(){
        buttonState = .recording
        delegate?.didStartRecording()
        generator.impactOccurred()
    }

    @objc open func didTouchUp() {
        buttonState = .idle
        delegate?.didEndRecording()
    }

    private func setRecording(to state: RecordingOptions) {
        let isRecording = state == .starting
        let duration: TimeInterval = 0.15
        circleLayer.contentsGravity = "center"

        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.fromValue = isRecording ? 1.0 : 0.6
        scale.toValue = isRecording ? 0.6 : 1.0
        scale.duration = duration
        scale.fillMode = kCAFillModeForwards
        scale.isRemovedOnCompletion = false

        let borderWidth = CABasicAnimation(keyPath: "borderWidth")
        borderWidth.fromValue = isRecording ? notRecordingButtonLineWidth : 0.0
        borderWidth.toValue = isRecording ? 0.0 : notRecordingButtonLineWidth
        borderWidth.duration = duration
        borderWidth.fillMode = kCAFillModeForwards
        borderWidth.isRemovedOnCompletion = false

        let circleColor = CABasicAnimation(keyPath: "backgroundColor")
        circleColor.toValue = isRecording ? UIColor.red.cgColor : UIColor.clear.cgColor
        circleColor.duration = duration
        circleColor.fillMode = kCAFillModeForwards
        circleColor.isRemovedOnCompletion = false

        let innerCircleAnimations = CAAnimationGroup()
        innerCircleAnimations.isRemovedOnCompletion = false
        innerCircleAnimations.fillMode = kCAFillModeForwards
        innerCircleAnimations.duration = duration
        innerCircleAnimations.animations = [scale, borderWidth, circleColor]

        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = isRecording ? 0.0 : 1.0
        fade.toValue = isRecording ? 1.0 : 0.0
        fade.duration = duration
        fade.fillMode = kCAFillModeForwards
        fade.isRemovedOnCompletion = false

        let scaleButton = CABasicAnimation(keyPath: "transform.scale")
        scaleButton.isRemovedOnCompletion = false
        scaleButton.fillMode = kCAFillModeForwards
        scaleButton.duration = duration
        scaleButton.fromValue = isRecording ? 1.0 : 1.2
        scaleButton.toValue = isRecording ? 1.2 : 1.0

        circleBorder.add(innerCircleAnimations, forKey: "circleBorderAnimations")
        progressLayer.add(fade, forKey: "fade")
        circleLayer.add(scaleButton, forKey: "scaleButton")
    }

    /**
     Set the relative length of the circle border to the specified progress

     - parameter newProgress: the relative lenght, a percentage as float.
     */
    func setProgress(_ newProgress: CGFloat) {
        progressLayer.strokeEnd = newProgress
    }
}
