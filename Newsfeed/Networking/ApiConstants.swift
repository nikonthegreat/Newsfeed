//
//  Api.swift
//  Newsfeed
//

import Foundation

class ApiConstants {
    static func getArticles() -> String {
        return "https://newsapi.org/v2/top-headlines"
    }
    
    static func getHeadlinesParameters() -> [String: String] {
        return [
            "apiKey": "fea974e1e6e14d9aae41a70962fefe59",
            "country": "us",
            "pageSize": "10",
            "page": "1",
        ]
    }
}
