//
//  ArticleListViewModel.swift
//  TestqiitaClient
//
//  Created by 舘佳紀 on 2021/02/09.
//  Copyright © 2021 Yoshiki Tachi. All rights reserved.
//

import RxSwift
import RxCocoa

/*
@Todo
- reloadDataの実装
- viewModelとViewのつなぎこみ
*/

protocol ArticleListViewModeTypes {
    var input: ArticleListViewModeInput { get }
    var output: ArticleListViewModeOutputs { get }
}

protocol ArticleListViewModeInput {
    func viewDidLoad()
}

protocol ArticleListViewModeOutputs {
    var articles: Driver<[Article]> { get }
    var loadingStatus: Driver<LoadingStatus> { get }
}

struct ArticleListViewModel: ArticleListViewModeTypes, ArticleListViewModeInput, ArticleListViewModeOutputs {
    private let disposeBeg = DisposeBag()
    
    
    struct Dependency {
        let model: ArticleListModel
        
        init(model: ArticleListModel = ArticleListModel()) {
            self.model = model
        }
    }
    
    //外部公開用と内部で使う用みたいな感じ
    private let articlesRelay = BehaviorRelay<[Article]>(value: [])
    let articles: Driver<[Article]>
    
    private let loadingStatusRelay = BehaviorRelay<LoadingStatus>(value: .initial)
    let loadingStatus: Driver<LoadingStatus>
    
    
    init(dependency: Dependency) {
        self.articles = articlesRelay.asDriver()
        self.loadingStatus = loadingStatusRelay.asDriver()
    }
    
    //よくわかってない
    private let viewDidLoadRelay = PublishRelay<Void>()
    func viewDidLoad() {
        viewDidLoadRelay.accept(())
    }
    
    //interfaceにアクセスする用
    var input: ArticleListViewModeInput { self }
    var output: ArticleListViewModeOutputs { self }
}
