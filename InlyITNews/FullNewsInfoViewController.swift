//
//  FullNewsInfoViewController.swift
//  InlyITNews
//
//  Created by Марат Хасанов on 02.05.2024.
//

import UIKit

class FullNewsInfoViewController: UIViewController {
    
    var text: String = "Очень длинный текст, который требует прокрутки для прочтения полностью..."
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var newsDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var fullContentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(fullContentLabel)
        scrollView.addSubview(newsImage)
        newsImage.addSubview(newsDescription)
        fullContentLabel.text = text
        setupConstraints()
    }
    
    private func setupConstraints() {
        // ScrollView Constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        // News Image Constraints
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            newsImage.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            newsImage.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            newsDescription.leadingAnchor.constraint(equalTo: newsImage.leadingAnchor),
            newsDescription.bottomAnchor.constraint(equalTo: newsImage.bottomAnchor)
            
        ])
        
        // Set aspect ratio constraint if you know the aspect ratio
        if let image = newsImage.image {
            let aspectRatio = image.size.width / image.size.height
            newsImage.heightAnchor.constraint(equalTo: newsImage.widthAnchor, multiplier: 1 / aspectRatio).isActive = true
        }
        
        // Full Content Label Constraints
        NSLayoutConstraint.activate([
            fullContentLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 20),
            fullContentLabel.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            fullContentLabel.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            fullContentLabel.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),  // Important to anchor to the bottom for correct scroll behavior
            fullContentLabel.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -40)
        ])
    }
}
