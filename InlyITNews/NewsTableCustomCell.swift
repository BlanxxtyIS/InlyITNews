//
//  NewsTableCustomCell.swift
//  InlyITNews
//
//  Created by Марат Хасанов on 02.05.2024.
//

import UIKit

final class NewsTableCustomCell: UITableViewCell {
    
    // MARK: - Public Properties
    static let reuseIdentifier = "NewsCell"
    
    lazy var newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var newsDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.backgroundColor = .black
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var newsAuthor: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var newsDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Private Properties
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    @objc
    private func didTapFavorite() {
        print("HHHHH")
    }
    
    private func setupUI() {
        contentView.addSubview(newsImage)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(newsDescription)
        contentView.addSubview(newsAuthor)
        contentView.addSubview(newsDate)
        
        NSLayoutConstraint.activate([
            newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsImage.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            newsImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            favoriteButton.widthAnchor.constraint(equalToConstant: 44),
            favoriteButton.heightAnchor.constraint(equalToConstant: 44),
            
            newsDescription.topAnchor.constraint(equalTo: newsImage.topAnchor, constant: 10),
            newsDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            newsDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            newsAuthor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            newsAuthor.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            newsDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            newsDate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
