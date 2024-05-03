//
//  FavoriteNewsViewController.swift
//  InlyITNews
//
//  Created by Марат Хасанов on 02.05.2024.
//

import UIKit

final class FavoriteNewsViewController: UIViewController {
    
    private lazy var allLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .white
        label.text = "Тут должны быть сохраненные новости"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        if let value = UserDefaults.standard.string(forKey: "ключ") {
            print(value)
            allLabel.text = value
        }
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(allLabel)
        
        NSLayoutConstraint.activate([
            allLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            allLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            allLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            allLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }
}
