//
//  FeedViewModel.swift
//  Newsfeed
//

import Foundation

class FeedViewModel {
    typealias ReadyBlock = () -> Void
    typealias ErrorBlock = (Error?) -> Void
    
    var onArticlesReady: ReadyBlock?
    var onArticlesError: ErrorBlock?
    
    var articles = [Article]()
    private var articleService: ArticleService
    
    init(articleService: ArticleService) {
        self.articleService = articleService
    }
    
    func getArticles() {
        articleService.getArticles { [weak self] articles, error in
            guard let articles = articles else {
                self?.onArticlesError?(error)
                return
            }
            
            self?.articles = articles
            self?.onArticlesReady?()
        }
    }
}
