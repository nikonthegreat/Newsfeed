//
//  News.swift
//  Newsfeed
//

import Foundation

struct ArticlesResponse: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

struct Article: Decodable {
    let source: Source
    let publishedAt: Date?
    let title: String?
    let urlToImage: String?
    let description: String?
    let content: String?
    let url: String?
    
    struct Source: Decodable {
        let name: String?
    }
    
    func getDateString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: publishedAt ?? Date())
    }
}
