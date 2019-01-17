//
//  FeedItemCell.swift
//  Newsfeed
//

import UIKit

class FeedItemCell: UITableViewCell {
    
    var article: NewsList.Article? {
        didSet {
            guard let article = article else {return}
            
            if let title = article.title {
                titleLabel.text = title
            }
            
            if let url = article.urlToImage {
                newsImageView.image = nil
                newsImageView.alpha = 0.0
                newsImageView.loadFromUrl(url)
            }
            
            if let description = article.description {
                descriptionLabel.text = description
            }
            
            if let source = article.source.name {
                sourceLabel.text = source
            }
            
            if let date = article.publishedAt {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd MMM HH:mm"
                publishedAtLabel.text = formatter.string(from: date)
            }
        }
    }
    
    let sourceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let newsImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        //image.backgroundColor = .red
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let publishedAtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let verticalLayout = UIStackView()
        verticalLayout.addArrangedSubview(sourceLabel)
        verticalLayout.addArrangedSubview(publishedAtLabel)
        verticalLayout.addArrangedSubview(newsImageView)
        verticalLayout.addArrangedSubview(titleLabel)
        verticalLayout.addArrangedSubview(descriptionLabel)

        self.contentView.addSubview(verticalLayout)
        self.contentView.backgroundColor = UIColor(rgb: 0xf5f5f5)
        
        verticalLayout.translatesAutoresizingMaskIntoConstraints = false
        verticalLayout.axis = .vertical
        verticalLayout.spacing = 6
        verticalLayout.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant:20).isActive = true
        verticalLayout.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant:20).isActive = true
        verticalLayout.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant:-20).isActive = true
        verticalLayout.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant:-20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
