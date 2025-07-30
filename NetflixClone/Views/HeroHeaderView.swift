//
//  HeroHeaderView.swift
//  NetflixClone
//
//  Created by Родион Холодов on 30.07.2025.
//

import UIKit

class HeroHeaderView: UIView {
    
    let buttonsStack = UIStackView()
    
    let playButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Play", for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.white.cgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        let action = UIAction { _ in
            print("play")
        }
        
        btn.addAction(action, for: .touchUpInside)
        
        return btn
    }()
    
    let downloadButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Download", for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.white.cgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        let action = UIAction { _ in
            print("download")
        }
        
        btn.addAction(action, for: .touchUpInside)
        
        
        return btn
    }()

    let heroImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = .hero
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        setButtonsStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    private func setButtonsStack() {
        buttonsStack.axis = .horizontal
        
        buttonsStack.spacing = 20
        
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonsStack)
        addSubview(playButton)
        addSubview(downloadButton)
        
        buttonsStack.addArrangedSubview(playButton)
        buttonsStack.addArrangedSubview(downloadButton)
        
        NSLayoutConstraint.activate([
            buttonsStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
        ])
    }
}
