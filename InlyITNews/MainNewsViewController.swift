//
//  MainNewsViewController.swift
//  InlyITNews
//
//  Created by Марат Хасанов on 02.05.2024.
//

import UIKit

class MainNewsViewController: UIViewController {
        
    var allData: [Marik] = []
    
    lazy var newsTableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableCustomCell.self, forCellReuseIdentifier: NewsTableCustomCell.reuseIdentifier)
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNews()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.allData = marik
            self.setupUI()
        }
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
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

    }
}

extension MainNewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FullNewsInfoViewController()
        vc.text = allData[indexPath.row].content
        present(vc, animated: true)
        print("Выбрали новость ")
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

extension MainNewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableCustomCell.reuseIdentifier,
                                                       for: indexPath) as? NewsTableCustomCell else { return UITableViewCell() }

        cell.newsAuthor.text = allData[indexPath.row].creator
        cell.newsImage.image = allData[indexPath.row].image
        cell.newsDate.text = allData[indexPath.row].pubDate
        cell.newsDescription.text = allData[indexPath.row].description
        return cell
    }
}
