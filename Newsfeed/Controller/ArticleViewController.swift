//
//  ArticleViewController.swift
//  Newsfeed
//

import UIKit

class ArticleViewController: UIViewController {
    
    private var article: Article?
    
    let newsImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let publishedAtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let urlTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.dataDetectorTypes = .link
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isSelectable = true
        textView.isEditable = false
        textView.isUserInteractionEnabled = true
        textView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textView.textContainer.maximumNumberOfLines = 1
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.backgroundColor = UIColor(rgb: 0xf5f5f5)
        return textView
    }()
    
    func updateWith(article: Article) {
        self.article = article
        title = article.source.name
        titleLabel.text =  article.title
        contentLabel.text = article.content
        publishedAtLabel.text = article.getDateString("dd MMM HH:mm")
        urlTextView.text = "Read more: \(article.url!)"
        
        if let url = article.urlToImage {
            newsImageView.image = nil
            newsImageView.alpha = 0.0
            newsImageView.loadFromUrl(url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView()
        let verticalLayout = UIStackView()
        verticalLayout.addArrangedSubview(newsImageView)
        verticalLayout.addArrangedSubview(titleLabel)
        verticalLayout.addArrangedSubview(publishedAtLabel)
        verticalLayout.addArrangedSubview(contentLabel)
        verticalLayout.addArrangedSubview(urlTextView)
        scrollView.addSubview(verticalLayout)
        
        view.addSubview(scrollView)
        view.backgroundColor = UIColor(rgb: 0xf5f5f5)
        
        verticalLayout.translatesAutoresizingMaskIntoConstraints = false
        verticalLayout.axis = .vertical
        verticalLayout.alignment = .fill
        verticalLayout.distribution = .equalSpacing
        verticalLayout.spacing = 6
        verticalLayout.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:20).isActive = true
        verticalLayout.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant:20).isActive = true
        verticalLayout.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant:-20).isActive = true
        verticalLayout.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant:-20).isActive = true
        verticalLayout.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant:-40).isActive = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

