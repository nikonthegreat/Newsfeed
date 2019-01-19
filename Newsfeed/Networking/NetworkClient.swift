//
//  NetworkClient.swift
//  Newsfeed
//

import Foundation

typealias LoadResult = (Data?, Error?) -> Void

class NetworkClient {
    func load(path: String, parameters: [String: String], completion: @escaping LoadResult) {
        guard let apiLink = URL(string: path) else { return }
        let url = apiLink.withParameters(parameters)!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    completion(nil, error)
                }
                else {
                    completion(data, error)
                }
            }
        }
        task.resume()
    }

}
