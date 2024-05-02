//
//  FullNewsInfoViewController.swift
//  InlyITNews
//
//  Created by Марат Хасанов on 02.05.2024.
//

import UIKit

class FullNewsInfoViewController: UIViewController {
    
    var text: String = "GGGGGG"
    
    private var fullContentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(fullContentLabel)
        fullContentLabel.text = text
        NSLayoutConstraint.activate([
            fullContentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fullContentLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }
}
