//
//  NewsArticleViewModel.swift
//  NewsArticle
//
//  Created by T0118RX on 07/02/25.
//

import Foundation

class NewsArticleViewModel {
    private var networkService: NewsArticleRepository
    var articles: [Article] = []
    
    init(networkService: NewsArticleRepository) {
        self.networkService = networkService
    }
    
    func fetchArticles(completion: @escaping (Bool) -> Void) {
        networkService.fetchArticles { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                completion(true)
            case .failure:
                self?.articles = []
                completion(false)
            }
        }
    }
}
