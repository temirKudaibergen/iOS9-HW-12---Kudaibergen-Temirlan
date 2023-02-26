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
    
    // MARK: - Lifcycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(shapeView)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png") ?? UIImage.remove)
        setupLayout()
        setupHierarchy()
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(shapeView)

    }
    
    private func setupLayout() {
        shapeView.snp.makeConstraints{ make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.height.equalTo(300)
            make.width.equalTo(300)
        }

    }
}

// MARK: - Actions

