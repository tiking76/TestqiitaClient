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
    private var tableView = UITableView()
    
    private let viewModel: ArticleListViewModeTypes
    private let disposeBeg = DisposeBag()
    private let refreshControl = UIRefreshControl()
    
    init(viewModel: ArticleListViewModeTypes) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        figure()
        bindToviewModel()
        viewModel.input.viewDidLoad()
    }
    
    private func figure() {
        tableView.register(ArticleListCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
                    tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                    tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])
    }
    
    private func bindToviewModel() {
        viewModel.output.articles.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: ArticleListCell.self)) {
                _, item, cell in
                cell.configure(title: item.title)
            }
            .disposed(by: disposeBeg)
        
        viewModel.output.articles.asObservable()
            .map{ _ in () }
            .bind(to: refreshControl.rx.endRefreshing)
            .disposed(by: disposeBeg)
    }
}

