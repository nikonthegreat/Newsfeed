//
//  FeedViewController.swift
//  Newsfeed
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    private var viewModel: FeedViewModel!
    private var feedTableView: UITableView!
    private var page: Int! = 1
    private var pageSize: Int! = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Newsfeed"
        
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
                self?.title = "Newsfeed (\(self?.viewModel.availablePages ?? 0) articles)"
            }
        }
        
        viewModel.initArticles(from: page, count: pageSize)
    }
    
    func fetchMoreArticles() {
        page += 1
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        viewModel.getArticles(from: page, count: pageSize)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleViewController = ArticleViewController()
        articleViewController.updateWith(article: viewModel.articles[indexPath.row])
        navigationController?.pushViewController(articleViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.availablePages
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedItemCell", for: indexPath as IndexPath) as! FeedItemCell
        if indexPath.row < viewModel.articles.count {
            cell.updateWith(article: viewModel.articles[indexPath.row])
        }
        else {
            cell.clear()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        var maxIndexRow = 0
        indexPaths.forEach {
            if maxIndexRow < $0.row {
                maxIndexRow = $0.row
            }
        }
        
        if maxIndexRow > viewModel.articles.count {
            fetchMoreArticles()
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths : [IndexPath]) {
    }
    
}

