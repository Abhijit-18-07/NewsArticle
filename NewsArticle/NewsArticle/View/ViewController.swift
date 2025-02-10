//
//  ViewController.swift
//  NewsArticle
//
//  Created by T0118RX on 07/02/25.
//

import UIKit

class ViewController: UIViewController {
    var viewModel: NewsArticleViewModel!
    @IBOutlet weak var articleTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let repository = NewsArticleRepository()
        viewModel = NewsArticleViewModel(networkService: repository)
        articleTableView.register(NewsArticleTableViewCell.nib(), forCellReuseIdentifier: NewsArticleTableViewCell.identifier)
        loadArticles()
    }
    
    func loadArticles() {
        viewModel.fetchArticles { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.articleTableView.reloadData()
                } else {
                    print("Show alert")
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = viewModel.articles[indexPath.row]
        
        guard let cell = articleTableView.dequeueReusableCell(withIdentifier: NewsArticleTableViewCell.identifier, for: indexPath) as? NewsArticleTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: article)
        return cell
    }
}

