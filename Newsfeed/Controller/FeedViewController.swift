//
//  FeedViewController.swift
//  Newsfeed
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var newsList: NewsList = NewsList()
    
    private var feedTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        feedTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        feedTableView.register(FeedItemCell.self, forCellReuseIdentifier: "FeedItemCell")
        feedTableView.dataSource = self
        feedTableView.delegate = self
        self.view.addSubview(feedTableView)
        
        loadNewsFeed { (result) in
            self.newsList = result
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                self.feedTableView.reloadData()
            }
        }
    }
    
    func loadNewsFeed(onLoad: @escaping (NewsList) -> Void) {
        let apiLink = URL(string: "https://newsapi.org/v2/top-headlines")!
        let query: [String: String] = [
            "apiKey": "fea974e1e6e14d9aae41a70962fefe59",
            "country": "us",
            "pageSize": "10",
            "page": "1",
            ]
        
        let url = apiLink.withParameters(query)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let result = try? JSONDecoder().decode(NewsList.self, from: data) {
                onLoad(result)
                print("Deserialization", result.status!, result.articles!.count, "articles fetched")
            }
            else {
                print("Deserialization error")
            }
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        task.resume()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.articles!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedItemCell", for: indexPath as IndexPath) as! FeedItemCell
        cell.article = newsList.articles![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

