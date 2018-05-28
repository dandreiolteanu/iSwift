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
    var scaleValue: CGFloat = 1.2
    private var notRecordingButtonLineWidth: CGFloat = 2.5
    private let generator = UIImpactFeedbackGenerator(style: .medium)
    private var progressLineWidth: CGFloat = 0.0

    private var isRecording: Bool = false
    var buttonState: CircleRecordingButtonState = .idle {
        didSet {
            switch buttonState {
            case .recording:
                print("recording")
                isRecording = true
                setRecording(to: .starting)
            case .idle:
                print("idle mode")
                isRecording = false
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

        let scale =  abs((1.0 - scaleValue)) * self.frame.size.height
        progressLineWidth = frame.size.width / 2 + scale

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

        let startAngle: CGFloat = CGFloat(Double.pi) + CGFloat(Double.pi / 2)
        let endAngle: CGFloat = CGFloat(Double.pi) * 3 + CGFloat(Double.pi / 2)
        let centerPoint: CGPoint = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        gradientMaskLayer = createGradientMask()
        gradientMaskLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        progressLayer = CAShapeLayer()
        progressLayer.path = UIBezierPath(arcCenter: centerPoint, radius: self.frame.size.width / 2 + 2, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
        progressLayer.backgroundColor = UIColor.clear.cgColor
        progressLayer.fillColor = nil
        progressLayer.strokeColor = UIColor.black.cgColor
        progressLayer.lineWidth = 0.0
        progressLayer.strokeStart = 0.0
        progressLayer.strokeEnd = 0.0
        gradientMaskLayer.mask = progressLayer
        layer.insertSublayer(gradientMaskLayer, at: 2)
    }

    private func createGradientMask() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.frame.size.height = self.bounds.size.height
        gradientLayer.frame.size.width = self.bounds.size.width
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.cornerRadius = self.frame.size.height / 2
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
        let duration: TimeInterval = 0.15
        let innerCircleMaxDuration: TimeInterval = 0.3
        circleLayer.contentsGravity = "center"

        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.fromValue = isRecording ? 1.0 : 0.6
        scale.toValue = isRecording ? 0.6 : 1.0
        scale.duration = isRecording ? duration : innerCircleMaxDuration
        scale.fillMode = kCAFillModeForwards
        scale.isRemovedOnCompletion = false

        let borderWidth = CABasicAnimation(keyPath: "borderWidth")
        borderWidth.fromValue = isRecording ? notRecordingButtonLineWidth : 0.0
        borderWidth.toValue = isRecording ? 0.0 : notRecordingButtonLineWidth
        borderWidth.duration = isRecording ? duration : innerCircleMaxDuration
        borderWidth.fillMode = kCAFillModeForwards
        borderWidth.isRemovedOnCompletion = false


        let circleColor = CABasicAnimation(keyPath: "backgroundColor")
        circleColor.toValue = isRecording ? UIColor.red.cgColor : UIColor.clear.cgColor
        circleColor.duration = isRecording ? duration : innerCircleMaxDuration
        circleColor.fillMode = kCAFillModeForwards
        circleColor.isRemovedOnCompletion = false

        let innerCircleAnimations = CAAnimationGroup()
        innerCircleAnimations.isRemovedOnCompletion = false
        innerCircleAnimations.fillMode = kCAFillModeForwards
        innerCircleAnimations.duration = isRecording ? duration : innerCircleMaxDuration
        innerCircleAnimations.animations = [scale, borderWidth, circleColor]

        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = isRecording ? 0.0 : 1.0
        fade.toValue = isRecording ? 1.0 : 0.0
        fade.duration = isRecording ? 2.0 : 0.0
        fade.fillMode = kCAFillModeForwards
        fade.isRemovedOnCompletion = false

        let scaleButton = CABasicAnimation(keyPath: "transform.scale")
        scaleButton.isRemovedOnCompletion = false
        scaleButton.fillMode = kCAFillModeForwards
        scaleButton.duration = isRecording ? duration : 0.2
        scaleButton.fromValue = isRecording ? 1.0 : scaleValue
        scaleButton.toValue = isRecording ? scaleValue : 1.0

        let progressScale = CABasicAnimation(keyPath: "transform.scale")
        progressScale.fromValue = isRecording ? 1.0 : scaleValue
        progressScale.toValue = isRecording ? scaleValue : 1.0
        progressScale.duration = isRecording ? duration : 0.2
        progressScale.fillMode = kCAFillModeForwards
        progressScale.isRemovedOnCompletion = false

        let progressLine = CABasicAnimation(keyPath: "lineWidth")
        progressLine.duration = isRecording ? duration : 0.5
        progressLine.fromValue = isRecording ? 0.0 : progressLineWidth
        progressLine.toValue = isRecording ? progressLineWidth : 0.0
        progressLine.fillMode = kCAFillModeForwards
        progressLine.isRemovedOnCompletion = false

        gradientMaskLayer.add(progressScale, forKey: "progressScale")
        gradientMaskLayer.add(fade, forKey: "fade")
        circleBorder.add(innerCircleAnimations, forKey: "circleBorderAnimations")
        circleLayer.add(scaleButton, forKey: "scaleButton")
        progressLayer.add(progressLine, forKey: "progressLineWidth")
    }

    /**
     Set the relative length of the circle border to the specified progress

     - parameter newProgress: the relative lenght, a percentage as float.
     */
    func setProgress(_ newProgress: CGFloat) {
        progressLayer.strokeEnd = newProgress
    }
}
