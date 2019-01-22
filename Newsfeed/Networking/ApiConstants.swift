//
//  Api.swift
//  Newsfeed
//

import Foundation

enum ApiConstants {
    static let ArticleURL: String = "https://newsapi.org/v2/top-headlines"
    static let ArticleURLParameters: [String: String] = [
        "apiKey": "fea974e1e6e14d9aae41a70962fefe59",
        "country": "us",
        "pageSize": "10",
        "page": "1",
        ]
}
