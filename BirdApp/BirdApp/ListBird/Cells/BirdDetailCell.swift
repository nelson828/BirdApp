//
//  BirdDetailCell.swift
//  BirdApp
//
//  Created by Nelson Ramirez on 28-08-22.
//

import UIKit

class BirdDetailCell: UITableViewCell {
    let image = UIImageView()
    let latinLabel = UILabel()
    
    let spanishComponent = FlagAndLabelComponent()
    let englishComponent = FlagAndLabelComponent()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(imageUrl: String, latinName: String, spanishName: String, englishName: String) {
        self.image.loadImageFromURL(urlString: imageUrl)
        latinLabel.text = latinName
        spanishComponent.configure(imageName: "icon-chilean-flag", text: spanishName)
        englishComponent.configure(imageName: "icon-american-flag", text: englishName)
    }
    
    private func setUpView() {
        setUpImage()
        setUpLatinLabel()
        setUpSpanishComponent()
        setUpEnglishComponent()
    }
    
    private func setUpImage() {
        image.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 100),
            image.widthAnchor.constraint(equalToConstant: 100),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setUpLatinLabel() {
        latinLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(latinLabel)
        
        NSLayoutConstraint.activate([
            latinLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 24),
            latinLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 13)
        ])
    }

    private func setUpSpanishComponent() {
        spanishComponent.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(spanishComponent)

        NSLayoutConstraint.activate([
            spanishComponent.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 24),
            spanishComponent.topAnchor.constraint(equalTo: latinLabel.bottomAnchor, constant: 5),
            spanishComponent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20)
        ])
    }

    private func setUpEnglishComponent() {
        englishComponent.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(englishComponent)

        NSLayoutConstraint.activate([
            englishComponent.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 24),
            englishComponent.topAnchor.constraint(equalTo: spanishComponent.bottomAnchor, constant: 2),
        ])
    }
}
