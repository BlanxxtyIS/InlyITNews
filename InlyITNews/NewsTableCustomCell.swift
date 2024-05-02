//
//  NewsTableCustomCell.swift
//  InlyITNews
//
//  Created by Марат Хасанов on 02.05.2024.
//

import UIKit

class NewsTableCustomCell: UITableViewCell {
    
    static let reuseIdentifier = "NewsCell"
    
    lazy var newsImage: UIImageView = {
        let image = UIImage(named: "0")
        let newsImage = UIImageView(image: image)
        newsImage.contentMode = .scaleToFill
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        return newsImage
    }()

    private lazy var favoriteButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var mainNewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func didTapFavorite() {
        print("Фаворит-фаворит")
    }
    
    private func setupUI() {
        contentView.addSubview(newsImage)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(mainNewLabel)
        
        let margins = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsImage.topAnchor.constraint(equalTo: margins.topAnchor),
            newsImage.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            
            favoriteButton.trailingAnchor.constraint(equalTo: newsImage.trailingAnchor),
            favoriteButton.topAnchor.constraint(equalTo: newsImage.topAnchor),
            
            mainNewLabel.leadingAnchor.constraint(equalTo: newsImage.leadingAnchor, constant: 8),
            mainNewLabel.bottomAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: -8)
        ])
    }
}
