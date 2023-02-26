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
    
    private var shapeView: UIImageView = {
        let loadImage = UIImageView()
        loadImage.image = UIImage(named: "circle")
        loadImage.translatesAutoresizingMaskIntoConstraints = false
        return loadImage
    }()
    
    private var timerLable: UILabel = {        var timerLable = UILabel()
        timerLable.text = " "
        timerLable.textColor = .black
        timerLable.textAlignment = .center
        timerLable.font = UIFont.boldSystemFont(ofSize: 84)
        timerLable.numberOfLines = 0
        timerLable.translatesAutoresizingMaskIntoConstraints = false
        return timerLable
    }()
    
    private var startButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.setImage(UIImage(named: "play"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget( .none, action: #selector(startTimer), for: .touchUpInside)
        return button
    }()
    
    
    
    // MARK: - Properties
    
    var timer = Timer()
    var durationTimer = 25
    let shapLayer = CAShapeLayer()
    
    // MARK: - Lifcycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.animationCircular()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(shapeView)
        view.addSubview(timerLable)
        view.addSubview(startButton)
        startButton.addTarget(self,
                              action: #selector(startTimer),
                              for: .touchUpInside)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png") ?? UIImage.remove)
        setupLayout()
        setupHierarchy()
        startTimer()
        animationCircular()
    }
    
    @objc func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        durationTimer -= 1
        timerLable.text = formatTime()
        if durationTimer == 15 {
            timer.invalidate()
        }
    }
    
    func formatTime()->String{
        let minutes = Int(durationTimer) / 60 % 60
        let seconds = Int(durationTimer) % 60
        return String(format:"%02i:%02i", minutes, seconds)
        
    }
    
    // MARK: - Animation
    func animationCircular() {
        let center = CGPoint(x: shapeView.frame.width / 2,
                             y: shapeView.frame.height / 2)
        let endAngle = (-CGFloat.pi / 2)
        let startAngel = 2 * CGFloat.pi + endAngle
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: 120,
                                        startAngle: startAngel,
                                        endAngle: endAngle,
                                        clockwise: true)
        shapLayer.path = circularPath.cgPath
        shapLayer.lineWidth = 21
        shapLayer.fillColor = UIColor.clear.cgColor
        shapLayer.strokeEnd = 1
        shapLayer.lineCap = CAShapeLayerLineCap.round
        shapLayer.strokeColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).cgColor
        shapeView.layer.addSublayer(shapLayer)
    }
    
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(shapeView)
        view.addSubview(timerLable)
        view.addSubview(startButton)
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
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(75)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
    }
}

// MARK: - Actions

