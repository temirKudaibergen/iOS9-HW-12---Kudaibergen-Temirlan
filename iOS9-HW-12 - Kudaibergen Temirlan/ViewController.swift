//
//  ViewController.swift
//  iOS9-HW-12 - Kudaibergen Temirlan
//
//  Created by Темирлан Кудайберген on 26.02.2023.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    private lazy var shapeView: UIImageView = {
        let loadImage = UIImageView()
        loadImage.image = UIImage(named: "circle")
        return loadImage
    }()
    
    private lazy var timerLable: UILabel = {
        var timerLable = UILabel()
        timerLable.text = " "
        timerLable.textColor = .black
        timerLable.textAlignment = .center
        timerLable.font = UIFont.boldSystemFont(ofSize: 84)
        timerLable.numberOfLines = 0
        return timerLable
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
    var durationTimer = 5
    let circularAnimation = CAShapeLayer()
    var isTimerStarted = true
    var isAnimationStarted = true
    
    // MARK: - Lifcycle
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        self.animationCircular()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(shapeView)
        view.addSubview(timerLable)
        view.addSubview(startButton)
        view.addSubview(pauseButton)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png") ?? UIImage.remove)
        setupLayout()
        setupHierarchy()
        startTimer()
        animationCircular()
    }
    
    
    
    // MARK: - Animation
    func animationCircular() {
        let center = CGPoint(x: view.frame.width / 2,
                             y: view.frame.height / 2)
        let endAngle = (-CGFloat.pi / 2)
        let startAngel = 2 * CGFloat.pi + endAngle
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: 120,
                                        startAngle: startAngel,
                                        endAngle: endAngle,
                                        clockwise: true)
        circularAnimation.path = circularPath.cgPath
        circularAnimation.lineWidth = 21
        circularAnimation.fillColor = UIColor.clear.cgColor
        circularAnimation.strokeEnd = 1
        circularAnimation.lineCap = CAShapeLayerLineCap.round
        circularAnimation.strokeColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).cgColor
        shapeView.layer.addSublayer(circularAnimation)
    }
    
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(shapeView)
        view.addSubview(timerLable)
        view.addSubview(startButton)
        view.addSubview(pauseButton)
    }
    
    private func setupLayout() {
        shapeView.snp.makeConstraints{ make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.height.equalTo(300)
            make.width.equalTo(300)
        }
        timerLable.snp.makeConstraints{ make in
            make.centerX.equalTo(shapeView)
            make.centerY.equalTo(shapeView)
        }
        startButton.snp.makeConstraints{ make in
            make.centerX.equalTo(view).offset(-20)
            make.centerY.equalTo(view).offset(75)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        pauseButton.snp.makeConstraints{ make in
            make.centerX.equalTo(view).offset(20)
            make.centerY.equalTo(view).offset(75)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
    }
    
    // MARK: - Actions

    @objc func startTimer() {
        if !isTimerStarted {
            startButton.setImage(UIImage(named: "pause"), for: .normal)
            timerAction()
            isTimerStarted = true
        } else {
            startButton.setImage(UIImage(named: "play"), for: .normal)
            timerLable.text = formatTime()
            timer.invalidate()
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
        timerLable.text = formatTime()
    }
    
    @objc func restartTime() {
        durationTimer = 5
        timer.invalidate()
        timerLable.text = formatTime()
        isTimerStarted = false
    }
    
    func formatTime()->String{
        let minutes = Int(durationTimer) / 60 % 60
        let seconds = Int(durationTimer) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}
