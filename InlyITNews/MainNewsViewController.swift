//
//  MainNewsViewController.swift
//  InlyITNews
//
//  Created by Марат Хасанов on 02.05.2024.
//

import UIKit

class MainNewsViewController: UIViewController {
    
    let testNews: [String] = Array(0...24).map {"\($0)"}
    
    private lazy var newsTableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableCustomCell.self, forCellReuseIdentifier: NewsTableCustomCell.reuseIdentifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(newsTableView)
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
        
    }
}

extension MainNewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Выбрали новость \(testNews[indexPath.row])")
    }
}

extension MainNewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        testNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableCustomCell.reuseIdentifier, for: indexPath) as? NewsTableCustomCell else { return UITableViewCell() }
        if let image = UIImage(named: testNews[indexPath.row]) {
            cell.newsImage.image = UIImage(named: testNews[indexPath.row])
        }
        cell.textLabel?.text = testNews[indexPath.row]
        return cell
    }
}
