//
//  ViewController.swift
//  iOS9-HW-12 - Kudaibergen Temirlan
//
//  Created by Темирлан Кудайберген on 26.02.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController, CAAnimationDelegate {
    
    // MARK: - UI
    
    private lazy var shapeView: UIImageView = {
        let loadImage = UIImageView()
        loadImage.image = UIImage(named: "circle")
        return loadImage
    }()
    
    private lazy var timerLabel: UILabel = {
        var timerLabel = UILabel()
        timerLabel.text = " "
        timerLabel.textColor = .black
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont.boldSystemFont(ofSize: 84)
        timerLabel.numberOfLines = 0
        return timerLabel
    }()
    
    private lazy var startButton: UIButton = {
        var imageFlag = false
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        return button
    }()
    
    private lazy var pauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 20
        button.setImage(UIImage(named: "stop"), for: .normal)
        button.addTarget(self, action: #selector(restartTime), for: .touchUpInside)
        return button
    }()
    
    
    
    // MARK: - Properties
    
    var timer = Timer()
    var durationTimer = 25
    let progresslayer = CAShapeLayer()
    var isTimerStarted = true
    var isAnimationStarted = false
    
    // MARK: - Lifcycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png") ?? UIImage.remove)
        view.addSubview(shapeView)
        view.addSubview(timerLabel)
        view.addSubview(startButton)
        view.addSubview(pauseButton)
        setupLayout()
        setupHierarchy()
        startTimer()
    }
    
    
    
    // MARK: - Animation
    
    func animationCircular() {
        progresslayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY),
                                          radius: 141,
                                          startAngle: -90.degreesToRadians,
                                          endAngle: 270.degreesToRadians,
                                          clockwise: true).cgPath
        progresslayer.strokeColor = UIColor.systemBlue.cgColor
        progresslayer.fillColor = UIColor.clear.cgColor
        progresslayer.lineWidth = 19
        view.layer.addSublayer(progresslayer)
    }
    
    func startResumeAnimation() {
        if !isAnimationStarted {
            startAnimation()
        } else {
            resumeAnimation()
        }
    }
    
    func startAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.keyPath = "strokeEnd"
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = Double(durationTimer)
        animation.delegate = self
        animation.isRemovedOnCompletion = false
        animation.isAdditive = true
        animation.fillMode = CAMediaTimingFillMode.forwards
        progresslayer.strokeEnd = 0.0
        progresslayer.add(animation, forKey: "strokeEnd")
        resetAnimation()
        isAnimationStarted = true
        
    }
    
    func resetAnimation() {
        progresslayer.speed = 1.0
        progresslayer.timeOffset = 0.0
        progresslayer.beginTime = 0.0
        progresslayer.strokeEnd = 0.0
        isAnimationStarted = false
    }
    
    func pauseAnimation() {
        let pausedTime = progresslayer.convertTime(CACurrentMediaTime(), from: nil)
        progresslayer.speed = 0.0
        progresslayer.timeOffset = pausedTime
    }
    
    func resumeAnimation() {
        let pausedTime = progresslayer.timeOffset
        progresslayer.speed = 1.0
        progresslayer.timeOffset = 0.0
        progresslayer.beginTime = 0.0
        let timeSincePaused = progresslayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        progresslayer.beginTime = timeSincePaused
    }
    
    func stopAnimation() {
        progresslayer.speed = 1.0
        progresslayer.timeOffset = 0.0
        progresslayer.beginTime = 0.0
        progresslayer.strokeEnd = 0.0
        progresslayer.removeAllAnimations()
        isAnimationStarted = false
    }
    
    internal func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        stopAnimation()
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(shapeView)
        view.addSubview(timerLabel)
        view.addSubview(startButton)
        view.addSubview(pauseButton)
    }
    
    private func setupLayout() {
        shapeView.snp.makeConstraints{
            $0.centerX.equalTo(view)
            $0.centerY.equalTo(view)
            $0.height.equalTo(300)
            $0.width.equalTo(300)
        }
        timerLabel.snp.makeConstraints{
            $0.centerX.equalTo(shapeView)
            $0.centerY.equalTo(shapeView)
        }
        startButton.snp.makeConstraints{
            $0.centerX.equalTo(view).offset(-20)
            $0.centerY.equalTo(view).offset(75)
            $0.height.equalTo(50)
            $0.width.equalTo(50)
        }
        pauseButton.snp.makeConstraints{
            $0.centerX.equalTo(view).offset(20)
            $0.centerY.equalTo(view).offset(75)
            $0.height.equalTo(50)
            $0.width.equalTo(50)
        }
    }
    
    // MARK: - Actions
    
    @objc func startTimer() {
        if !isTimerStarted {
            animationCircular()
            startResumeAnimation()
            startButton.setImage(UIImage(named: "pause"), for: .normal)
            timerAction()
            isTimerStarted = true
        } else {
            startButton.setImage(UIImage(named: "play"), for: .normal)
            timerLabel.text = formatTime()
            timer.invalidate()
            pauseAnimation()
            isTimerStarted = false
        }
    }
    
    @objc func timerAction() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timeValueUpdate),
                                     userInfo: nil, repeats: true)
    }
    
    @objc func timeValueUpdate() {
        durationTimer -= 1
        if durationTimer == 0 {
            timer.invalidate()
        }
        timerLabel.text = formatTime()
    }
    
    @objc func restartTime() {
        stopAnimation()
        startButton.setImage(UIImage(named: "play"), for: .normal)
        durationTimer = 5
        timer.invalidate()
        timerLabel.text = formatTime()
        isTimerStarted = false
    }
    
    func formatTime()->String{
        let minutes = Int(durationTimer) / 60 % 60
        let seconds = Int(durationTimer) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}
