//
//  FlagAndLabelComponent.swift
//  BirdApp
//
//  Created by Nelson Ramirez on 28-08-22.
//

import UIKit

class FlagAndLabelComponent: UIView {
    private let image = UIImageView()
    private let label = UILabel()

    init() {
        super.init(frame: .zero)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(imageName: String, text: String) {
        image.image = UIImage(named: imageName)
        label.text = text
    }
    
    private func setUpView() {
        setUpImage()
        setUpLabel()
    }
    
    private func setUpImage() {
        image.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.topAnchor.constraint(equalTo: topAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: 22),
            image.widthAnchor.constraint(equalToConstant: 17)
        ])
    }
    
    private func setUpLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 12),
            label.centerYAnchor.constraint(equalTo: image.centerYAnchor)
        ])
    }
}
