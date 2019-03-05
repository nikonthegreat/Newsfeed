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
    typealias ArticleLoadCompletion = ([Article]?, Int?, Error?) -> Void
    func getArticles(from page: Int, count pageSize: Int, result: @escaping ArticleLoadCompletion)
}

extension NetworkService : ArticleService {
    func getArticles(from page: Int, count pageSize: Int, result: @escaping ArticleLoadCompletion) {
        
        var params = ApiConstants.ArticleURLParameters
        params["pageSize"] = String(pageSize)
        params["page"] = String(page)
        
        client.load(path: ApiConstants.ArticleURL, parameters: params) { (data, error) in
            guard let data = data else {
                result(nil, 0, error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let res = try decoder.decode(ArticlesResponse.self, from: data)
                result(res.articles, res.totalResults, nil)
            }
            catch {
                if let errorStr = String(data: data, encoding: .utf8) {
                    print(errorStr)
                }

                result(nil, 0, error)
            }
        }
    }
}

