//
//  NetworkClient.swift
//  InlyITNews
//
//  Created by Марат Хасанов on 02.05.2024.
//

import UIKit

struct News: Codable {
    let status: String
    let totalResults: Int
    let results: [NewsArticle]
    let nextPage: String?
}

struct NewsArticle: Codable {
    let article_id: String
    let title: String
    let link: String
    let creator: [String]?
    let description: String?
    let pubDate: String
    let image_url: String?
    let content: String
}

struct Article {
    let creator: String
    let pubDate: String
    let description: String
    let image: UIImage?
    let content: String
    let link: String
}

final class NetworkClient {
    
    var neededArticleData: [Article] = []
    
    func loadNewsAll() {
        guard let url = URL(string: "https://newsdata.io/api/1/news?apikey=pub_43324387e4fcaf33b39274142680983e5c772&q=pizza") else {
            print("Неккоректный URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("apikey", forHTTPHeaderField: "pub_43324387e4fcaf33b39274142680983e5c772")
        request.setValue("q", forHTTPHeaderField: "pizza")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) {(data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print(error)
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Неверный ответ")
                return
            }
            if let data = data {
                self.parseNewsData(data: data)
            }
        }
        task.resume()
    }
    
    private func parseNewsData(data: Data) {
        let decoder = JSONDecoder()
        do {
            let newsResponse = try decoder.decode(News.self, from: data)
            let group = DispatchGroup()
            
            for article in newsResponse.results {
                var creator = ""
                if let creators = article.creator, !creators.isEmpty {
                    creator = creators.joined(separator: ", ")
                }
                
                let pubDate = article.pubDate
                let description = article.description ?? "ПУСТО"
                let content = article.content
                let link = article.link
                
                if let imageUrlString = article.image_url, let imageUrl = URL(string: imageUrlString) {
                    group.enter()
                    loadImage(from: imageUrl) { image in
                        let newItem = Article(creator: creator, pubDate: pubDate, description: description, image: image, content: content, link: link)
                        self.neededArticleData.append(newItem)
                        group.leave()
                    }
                } else {
                    let newItem = Article(creator: creator, pubDate: pubDate, description: description, image: nil, content: content, link: link)
                    neededArticleData.append(newItem)
                }
            }
            
            group.notify(queue: .main) {
                print("Все данные загружены и добавлены в массив")
            }
            
        } catch {
            print("Error parsing data: \(error)")
        }
    }
    
    
    private func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error loading image: \(String(describing: error))")
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }
        task.resume()
    }
}

