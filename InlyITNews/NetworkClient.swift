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
}

func loadNews() {
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
            parseNewsData(data: data)
        }
    }
    task.resume()
}

func parseNewsData(data: Data) {
    let decoder = JSONDecoder()
    
    do {
        let newsResponse = try decoder.decode(News.self, from: data)
        for article in newsResponse.results {
            //print("Title: \(article.title), Link: \(article.link)")
            print("Автор: \(article.creator ?? ["ПУСТО"])")
            print("Дата: \(article.pubDate)")
            print("Описание: \(article.description ?? "ПУСТТО")")
            if let imageUrlString = article.image_url, let imageUrl = URL(string: imageUrlString) {
                loadImage(from: imageUrl) { image in
                    DispatchQueue.main.async {
                        // Предполагается, что у вас есть UIImageView с именем imageView
                        guard let image = image else {
                            return
                        }
                        print(image)
                    }
                }
            }
        }
        
    } catch {
        print("Error parsing data: \(error)")
    }
}


func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
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

