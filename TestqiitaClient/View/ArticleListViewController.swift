//
//  ArticleListViewController.swift
//  TestqiitaClient
//
//  Created by 舘佳紀 on 2020/08/13.
//  Copyright © 2020 Yoshiki Tachi. All rights reserved.
//

import UIKit
import SafariServices

private let reuseIdentifier = "ArticleListCell"

class ArticleListViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ArticleListCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        return tableView
    }()
    
    private let activityIndicator =  UIActivityIndicatorView.Style.medium
    let viewModel = ArticleListViewModel()
    private var items : [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        viewModel.featch { [weak self] (articleList) in
            guard let articleList = articleList  else { return }
            
            
            self?.titleLabel.text = articleList[0].title
            self?.items = articleList
            self?.tableView.reloadData()
            
        }
        // Do any additional setup after loading the view.
    }
}

extension ArticleListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleListCell", for: indexPath) as! ArticleListCell
        
        let article = items[indexPath.row]
        cell.titleLabel.text = article.title
        
        return cell
    }
}

extension ArticleListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: items[indexPath.row].url) else { return }
        
        let safariViewController  =  SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
}

