//
//  NewsArticleRepository.swift
//  NewsArticle
//
//  Created by T0118RX on 07/02/25.
//

import Foundation

class NewsArticleRepository {
    
    private let baseURL: String
    private let session: URLSession
    init(baseURL: String = "https://newsapi.org/v2/everything?q=tesla&from=2025-01-08&sortBy=publishedAt&apiKey=0fdb39726c1044b29b7237fb229d9010", session: URLSession = URLSession.shared) {
        self.baseURL = baseURL
        self.session = session
    }
    
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            do {
                let articles = try JSONDecoder().decode(ArticleResponse.self, from: data).articles
                completion(.success(articles))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
