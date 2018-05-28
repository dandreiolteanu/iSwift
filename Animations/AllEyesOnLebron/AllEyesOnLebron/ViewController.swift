//
//  ViewController.swift
//  AllEyesOnLebron
//
//  Created by Olteanu Andrei on 26/05/2018.
//  Copyright © 2018 Olteanu Andrei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var circleRecordingButton: CircleRecordingButton!
    private var progressTimer: Timer!
    private var progress: CGFloat = 0

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        circleRecordingButton = CircleRecordingButton(frame: CGRect(x:0, y: 0, width: 70, height: 70))
        circleRecordingButton.delegate = self
        circleRecordingButton.center.x = view.center.x
        circleRecordingButton.center.y = view.frame.size.height - 70 - 70
        view.addSubview(circleRecordingButton)
    }
}

extension ViewController: CircleRecordingButtonDelegate {
    func didStartRecording() {
        self.progressTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }

    func didEndRecording() {
        progressTimer.invalidate()
        progress = 0
    }

    @objc private func updateProgress() {
        let maxDuration: CGFloat = 5
        progress = progress + CGFloat(0.05) / maxDuration
        circleRecordingButton.setProgress(progress)
        if progress >= 1 {
            progressTimer.invalidate()
            progress = 0
        }
    }
}

