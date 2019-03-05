//
//  FeedViewModel.swift
//  Newsfeed
//

import Foundation

class FeedViewModel {
    typealias ReadyBlock = () -> Void
    typealias ErrorBlock = (Error?) -> Void
    
    var onAvailablePages: ReadyBlock?
    var onArticlesReady: ReadyBlock?
    var onArticlesError: ErrorBlock?
    
    var availablePages: Int = 0
    var articles = [Article]()
    private var articleService: ArticleService
    
    init(articleService: ArticleService) {
        self.articleService = articleService
    }
    
    private func parseServiceResult(_ articles: [Article]?, _ availablePages: Int?, _ error: Error?) {
        guard let articles = articles else {
            onArticlesError?(error)
            return
        }
        
        self.availablePages = availablePages ?? 0
        self.articles += articles
    }
    
    func initArticles(from page: Int, count pageSize: Int) {
        articleService.getArticles(from: page, count: pageSize) { [weak self] articles, availablePages, error in
            self?.parseServiceResult(articles, availablePages, error)
            self?.onArticlesReady?()
        }
    }
    
    func getArticles(from page: Int, count pageSize: Int) {
        articleService.getArticles(from: page, count: pageSize) { [weak self] articles, availablePages, error in
            self?.parseServiceResult(articles, availablePages, error)
        }
    }
}
