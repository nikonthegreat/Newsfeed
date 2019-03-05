//
//  FeedItemCell.swift
//  Newsfeed
//

import UIKit

class FeedItemCell: UITableViewCell {
    
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
    
    func updateWith(article: Article?) {
        clear()
        guard let article = article else {return}
        
        titleLabel.text =  article.title
        descriptionLabel.text = article.description
        sourceLabel.text = article.source.name
        publishedAtLabel.text = article.getDateString("dd MMM HH:mm")
        
        if let url = article.urlToImage {
            newsImageView.image = nil
            newsImageView.alpha = 0.0
            newsImageView.loadFromUrl(url)
        }
    }
    
    func clear() {
        titleLabel.text = nil
        descriptionLabel.text = nil
        sourceLabel.text = nil
        publishedAtLabel.text = nil
        newsImageView.image = nil
        newsImageView.alpha = 0.0
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let verticalLayout = UIStackView()
        verticalLayout.addArrangedSubview(sourceLabel)
        verticalLayout.addArrangedSubview(publishedAtLabel)
        verticalLayout.addArrangedSubview(newsImageView)
        verticalLayout.addArrangedSubview(titleLabel)
        verticalLayout.addArrangedSubview(descriptionLabel)

        contentView.addSubview(verticalLayout)
        contentView.backgroundColor = UIColor(rgb: 0xf5f5f5)
        
        verticalLayout.translatesAutoresizingMaskIntoConstraints = false
        verticalLayout.axis = .vertical
        verticalLayout.spacing = 6
        verticalLayout.topAnchor.constraint(equalTo: contentView.topAnchor, constant:20).isActive = true
        verticalLayout.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:20).isActive = true
        verticalLayout.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:-20).isActive = true
        verticalLayout.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:-20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
