//
//  NewsArticleTableViewcell.swift
//  NewsArticle
//
//  Created by T0118RX on 07/02/25.
//

import UIKit

class NewsArticleTableViewCell: UITableViewCell {
    
    static let identifier = "NewsArticleTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "NewsArticleTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(with article: Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description ?? "No description available"
        authorLabel.text = "Author: \(article.author ?? "Unknown")"
        publishedDateLabel.text = "Published on: \(article.publishedAt)"
        contentLabel.text = article.content ?? "No content available"
        if let imageUrlString = article.urlToImage, let imageUrl = URL(string: imageUrlString) {
            articleImageView.load(url: imageUrl)
        } else {
            articleImageView.image = nil
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}
