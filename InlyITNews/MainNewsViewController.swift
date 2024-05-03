//
//  MainNewsViewController.swift
//  InlyITNews
//
//  Created by Марат Хасанов on 02.05.2024.
//

import UIKit

final class MainNewsViewController: UIViewController {
        
    // MARK: - Public Properties
    var allData: [Article] = []
    
    let networkClient = NetworkClient()
    
    lazy var newsTableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableCustomCell.self, forCellReuseIdentifier: NewsTableCustomCell.reuseIdentifier)
        table.backgroundColor = .black
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.loadNewsAll()
        loadNews()
    }
    
    
    // MARK: - Private Methods
    func loadNews() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.allData = self.networkClient.neededArticleData
            self.setupUI()
            self.newsTableView.reloadData()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(newsTableView)
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

    }
}

// MARK: - UITableViewDelegate
extension MainNewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = FullNewsInfoViewController()
        vc.text = allData[indexPath.row].content
        vc.newsImage.image = allData[indexPath.row].image!
        vc.newsDescription.text = allData[indexPath.row].description
        vc.newsAuthor.text = allData[indexPath.row].creator
        vc.newsDate.text = allData[indexPath.row].pubDate
        vc.urlNews = allData[indexPath.row].link
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = allData[indexPath.row].image else {
            return 0
        }
        let imageInsets = UIEdgeInsets(top: 0, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = image.size.width
        let scale = imageViewWidth / imageWidth
        let cellHeight = image.size.height * scale + imageInsets.top + imageInsets.bottom
        return cellHeight
    }
}

// MARK: - UITableViewDataSource
extension MainNewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableCustomCell.reuseIdentifier,
                                                       for: indexPath) as? NewsTableCustomCell else { return UITableViewCell() }
        cell.valueForFavorite = allData[indexPath.row].description
        cell.newsAuthor.text = allData[indexPath.row].creator
        cell.newsImage.image = allData[indexPath.row].image
        cell.newsDate.text = allData[indexPath.row].pubDate
        cell.newsDescription.text = allData[indexPath.row].description
        return cell
    }
}
