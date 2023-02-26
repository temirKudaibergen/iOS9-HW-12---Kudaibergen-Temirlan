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
        let lable = UILabel()
        lable.text = "25"
        lable.textColor = .black
        lable.textAlignment = .center
        lable.font = UIFont.boldSystemFont(ofSize: 84)
        lable.numberOfLines = 0
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private var startButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.setImage(UIImage(named: "play"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    // MARK: - Lifcycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(shapeView)
        shapeView.addSubview(timerLable)
        shapeView.addSubview(startButton)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png") ?? UIImage.remove)
        setupLayout()
        setupHierarchy()
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(shapeView)
        shapeView.addSubview(timerLable)
        shapeView.addSubview(startButton)

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
        }
        

    }
}

// MARK: - Actions

