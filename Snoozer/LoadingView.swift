//
//  LoadingView.swift
//  Snoozer
//
//  Created by Nathan Ryan Sidik on 2/20/24.
//

import Foundation

import UIKit

class LoadingView: UIView {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        // Assuming you have an image named "logo" in your assets
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .black // Change the background color as needed
        
        addSubview(logoImageView)
        addSubview(loadingLabel)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20), // Adjust positioning as needed
            logoImageView.widthAnchor.constraint(equalToConstant: 100), // Adjust size as needed
            logoImageView.heightAnchor.constraint(equalToConstant: 100), // Adjust size as needed
            
            loadingLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20), // Adjust spacing as needed
            loadingLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
