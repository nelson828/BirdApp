//
//  BigPictureViewController.swift
//  BirdApp
//
//  Created by Nelson Ramirez on 28-08-22.
//

import UIKit

class BigPictureViewController: UIViewController {
    private let imageUrl: String
    private let imageView = UIImageView()
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpView()
    }
    
    private func setUpView() {
        setUpImage()
    }
    
    private func setUpImage() {
        imageView.loadImageFromURL(urlString: imageUrl)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.enableZoom()
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
