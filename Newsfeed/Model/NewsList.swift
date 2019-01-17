//
//  News.swift
//  Newsfeed
//

import Foundation

struct NewsList: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
    
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
        
        init() {
            self.source = Source(name: String())
            self.publishedAt = Date()
            self.title = String()
            self.urlToImage = String()
            self.description = String()
            self.content = String()
            self.url = String()
        }
        
        enum CodingKeys : String, CodingKey {
            case source
            case publishedAt
            case title
            case urlToImage
            case description
            case content
            case url
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            
            self.source = try values.decode(Source.self, forKey: .source)
            self.title = try values.decode(String.self, forKey: .title)
            self.urlToImage = try values.decode(String.self, forKey: .urlToImage)
            self.description = try values.decode(String.self, forKey: .description)
            self.content = try values.decode(String.self, forKey: .content)
            self.url = try values.decode(String.self, forKey: .url)
            
            let dateString = try values.decode(String.self, forKey: .publishedAt)
            if let date = ISO8601DateFormatter().date(from: dateString) {
                self.publishedAt = date
            }
            else {
                self.publishedAt = Date()
            }
        }
    }
    
    init() {
        self.status = "null"
        self.totalResults = 0
        
        let article = Article()
        self.articles = [article]
    }
}
