//
//  FullNewsInfoViewController.swift
//  InlyITNews
//
//  Created by Марат Хасанов on 02.05.2024.
//

import UIKit
import WebKit
import SafariServices

final class FullNewsInfoViewController: UIViewController {
    
    // MARK: - Public Properties
    var text: String = "Очень длинный текст, который требует прокрутки для прочтения полностью..."
    
    var urlNews = ""
    
    lazy var newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var newsDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 0
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
    private var webInfo: WKWebView?
    
    private lazy var infoWebButton: UIButton = {
       let button = UIButton()
        button.setTitle("Ссылка на источник", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        button.setTitleColor(UIColor(named: "ypUniBlue"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.heightAnchor.constraint(equalToConstant: 26).isActive = true
        button.widthAnchor.constraint(equalToConstant: 202).isActive = true
        button.addTarget(self, action: #selector(showUserInfo), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var fullContentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupUI()
    }
    
    // MARK: - Public Methods
    func showSafariView() -> SFSafariViewController {
        let urlString = urlNews
        guard let url = URL(string: urlString) else { fatalError("Invalid URL") }
        let vc = SFSafariViewController(url: url)
        return vc
    }
    
    // MARK: - Private Methods
    @objc
    private func showUserInfo() {
        let vc = showSafariView()
        present(vc, animated: true)
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(fullContentLabel)
        scrollView.addSubview(newsImage)
        newsImage.addSubview(newsDescription)
        scrollView.addSubview(newsAuthor)
        scrollView.addSubview(newsDate)
        scrollView.addSubview(infoWebButton)
        fullContentLabel.text = text
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            newsImage.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            newsImage.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            newsImage.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            newsAuthor.topAnchor.constraint(equalTo: newsImage.bottomAnchor),
            newsAuthor.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            infoWebButton.topAnchor.constraint(equalTo: newsAuthor.bottomAnchor),
            infoWebButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            newsDate.topAnchor.constraint(equalTo: newsImage.bottomAnchor),
            newsDate.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            
            newsDescription.leadingAnchor.constraint(equalTo: newsImage.leadingAnchor, constant: 20),
            newsDescription.trailingAnchor.constraint(equalTo: newsImage.trailingAnchor, constant: -20),
            newsDescription.bottomAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: -10),
            
            fullContentLabel.topAnchor.constraint(equalTo: infoWebButton.bottomAnchor, constant: 20),
            fullContentLabel.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            fullContentLabel.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            fullContentLabel.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            fullContentLabel.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -40)
        ])
        
        if let image = newsImage.image {
            let aspectRatio = image.size.width / image.size.height
            newsImage.heightAnchor.constraint(equalTo: newsImage.widthAnchor, multiplier: 1 / aspectRatio).isActive = true
        }
    }
}
