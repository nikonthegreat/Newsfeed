//
//  ArticleViewController.swift
//  Newsfeed
//

import UIKit

class ArticleViewController: UIViewController {
    
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = article?.source.name
    }
}

