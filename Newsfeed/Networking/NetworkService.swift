//
//  NetworkService.swift
//  Newsfeed
//

import Foundation

class NetworkService {
    private(set) var client: NetworkClient
    
    init() {
        client = NetworkClient()
    }
}

protocol ArticleService {
    typealias ArticleLoadCompletion = ([Article]?, Error?) -> Void
    func getArticles(result: @escaping ArticleLoadCompletion)
}

extension NetworkService : ArticleService {
    func getArticles(result: @escaping ArticleLoadCompletion) {
        client.load(path: ApiConstants.getArticles(), parameters: ApiConstants.getHeadlinesParameters()) { (data, error) in
            guard let data = data else {
                result(nil, error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let res = try decoder.decode(ArticlesResponse.self, from: data)
                result(res.articles, nil)
            }
            catch {
                result(nil, error)
            }
        }
    }
}

