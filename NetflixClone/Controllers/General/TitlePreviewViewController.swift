//
//  TitlePreviewViewController.swift
//  NetflixClone
//
//  Created by Родион Холодов on 07.08.2025.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        return webView
    }()
    
    private let label: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 32, weight: .bold)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    private let descriptionScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isDirectionalLockEnabled = true
        
        return scrollView
    }()
    
    private let scrollContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 20, weight: .regular)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    private let downloadButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Download", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .red
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(webView)
        view.addSubview(label)
        view.addSubview(descriptionScrollView)
        descriptionScrollView.addSubview(scrollContentView)
        descriptionScrollView.addSubview(descriptionLabel)
        descriptionScrollView.addSubview(downloadButton)
        
        configureConstraint()
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            webView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.3),
            
            label.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionScrollView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            descriptionScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    
            descriptionLabel.widthAnchor.constraint(equalTo: descriptionScrollView.widthAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: descriptionScrollView.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionScrollView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionScrollView.trailingAnchor),
            
            downloadButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            downloadButton.centerXAnchor.constraint(equalTo: descriptionScrollView.centerXAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.3),
            downloadButton.bottomAnchor.constraint(equalTo: descriptionScrollView.bottomAnchor, constant: -20)
            
        ])
    }
    
    public func configure(with viewModel: TitlePreviewViewModel) {
        
        guard let url = URL(string: "https://www.youtube.com/embed/1YDSsF-8Dm4") else { return }
        webView.load(URLRequest(url: url))
        label.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }
}
