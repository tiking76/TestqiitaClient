//
//  ArticleListViewController.swift
//  TestqiitaClient
//
//  Created by 舘佳紀 on 2020/08/13.
//  Copyright © 2020 Yoshiki Tachi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SafariServices

private let reuseIdentifier = "ArticleListCell"

class ArticleListViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ArticleListCell.self, forCellReuseIdentifier: reuseIdentifier)
        return tableView
    }()
    
    private let viewModel: ArticleListViewModel
    private let disposeBeg = DisposeBag()
    
    init(viewModel: ArticleListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
                    tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                    tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])
        viewModel.fetch()
    }
}

extension ArticleListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.articles.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleListCell", for: indexPath) as! ArticleListCell
        let article = viewModel.output.articles.value[indexPath.row]
        cell.titleLabel.text = article.title
        return cell
    }
}

extension ArticleListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: viewModel.output.articles.value[indexPath.row].url) else { return }
        let safariViewController  =  SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
}

