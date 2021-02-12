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
    
    /*
     @Memo
     値の流れ方としては
     fetch -> BehaviorRelay -> Driver
     となっている
     今回は
     BehaviorRelayとfetchはbindで繋がっていて
     BehaviorRelayとDriverはBehaviorRelayをasDriverをしているから繋がっている
    */
    
    //外部公開用と内部で使う用みたいな感じなのかな？
    private let articlesRelay = BehaviorRelay<[Article]>(value: [])
    let articles: Driver<[Article]>
    
    private let loadingStatusRelay = BehaviorRelay<LoadingStatus>(value: .initial)
    let loadingStatus: Driver<LoadingStatus>
    
    
    init(dependency: Dependency) {
        self.articles = articlesRelay.asDriver()
        self.loadingStatus = loadingStatusRelay.asDriver()
        
        viewDidLoadRelay.asObservable()
            .map{ _ in LoadingStatus.loading }
            .bind(to: loadingStatusRelay)
            .disposed(by: disposeBeg)
        
        /*
         @Memo
         ここでonNext(),onErrorのイベントをObservable<Event<Article>>として変換して、
         別々のストリームとして扱えるようにしていて、
         最後のshare()でHotObservablesに変換して一つの入力に対して
         これ以降のobservableがそれぞれ独立したストリームとしてデータ更新を行えるようにしている
         */
        let fetched = viewDidLoadRelay.asObservable().flatMap { dependency.model.fetch().asObservable().materialize()}.share()
        
        //ここなんもわからんけど動いた
        fetched.flatMap { $0.element.map(Observable.just) ?? .empty() }
            .do(onNext: { [self] _ in
                loadingStatusRelay.accept(.loadSuccess)
            })
            .bind(to: articlesRelay)
            .disposed(by: disposeBeg)
        
        fetched.flatMap { $0.error.map(Observable.just) ?? .empty() }
            .do(onNext: { [self] _ in
                loadingStatusRelay.accept(.loadFaild)
            })
            .subscribe()
            .disposed(by: disposeBeg)
    }
    
    //よくわかってない
    private let viewDidLoadRelay = PublishRelay<Void>()
    func viewDidLoad() {
        viewDidLoadRelay.accept(())
    }
    
    //interfaceとしてアクセスする用
    var input: ArticleListViewModeInput { self }
    var output: ArticleListViewModeOutputs { self }
}
