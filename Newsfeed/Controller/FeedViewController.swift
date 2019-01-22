//
//  FeedViewController.swift
//  Newsfeed
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    private var viewModel: FeedViewModel!
    private var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = view.frame.width
        let displayHeight: CGFloat = view.frame.height
        
        feedTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        feedTableView.register(FeedItemCell.self, forCellReuseIdentifier: "FeedItemCell")
        feedTableView.dataSource = self
        feedTableView.delegate = self
        feedTableView.prefetchDataSource = self
        view.addSubview(feedTableView)
        view.backgroundColor = UIColor(rgb: 0xf5f5f5)

        viewModel = FeedViewModel(articleService: NetworkService())
        viewModel.onArticlesReady = { [weak self] in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self?.feedTableView.reloadData()
            }
        }
    
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        viewModel.getArticles()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let articleViewController = ArticleViewController()
//        articleViewController.article = newsList.articles![indexPath.row]
//        navigationController?.pushViewController(articleViewController, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedItemCell", for: indexPath as IndexPath) as! FeedItemCell
        cell.updateWith(article: viewModel.articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print("prefetchRowsAt \(indexPaths)")
        
        let needsFetch = indexPaths.contains { $0.row >= self.viewModel.articles.count }
        if needsFetch {
            print("fetch more")
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("cancelPrefetchingForRowsAt \(indexPaths)")
    }
}

