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
    
    private var timerLable: UILabel = {
        var isWorkTime = Bool()
        var isStarted = Bool()
        var timerLable = UILabel()
        timerLable.text = ""
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
        button.setTitle("Play", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    

    // MARK: - Properties
    
    var timer = Timer()
    var durationTimer = 25
    
    // MARK: - Lifcycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(shapeView)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        timerLable.text = "\(durationTimer)"
        shapeView.addSubview(timerLable)
        shapeView.addSubview(startButton)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png") ?? UIImage.remove)
        setupLayout()
        setupHierarchy()
        
    }
     
    @objc func startButtonTapped() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        
        durationTimer -= 1
        timerLable.text = "\(durationTimer)"
        print(durationTimer)
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(shapeView)
        shapeView.addSubview(timerLable)
        shapeView.addSubview(startButton)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
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
            make.centerX.equalTo(shapeView)
            make.centerY.equalTo(shapeView).offset(75)
            make.height.equalTo(700)
            make.width.equalTo(300)
        }
    }
}

// MARK: - Actions

