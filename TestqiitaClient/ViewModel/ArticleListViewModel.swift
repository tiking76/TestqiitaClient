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

protocol ArticleListViewModelTypes {
    var input: ArticleListViewModelInput { get }
    var output: ArticleListViewModelOutput { get }
}

protocol ArticleListViewModelInput {
    func viewDidLoad()
}

protocol ArticleListViewModelOutput {
    var articles: Driver<[Article]> { get }
    var loadingStatus: Driver<LoadingStatus> { get }
}

struct ArticleListViewModel: ArticleListViewModelTypes, ArticleListViewModelInput, ArticleListViewModelOutput {
    private let disposeBag = DisposeBag()
    
    
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
            .disposed(by: disposeBag)
        
        /*
         @Memo
         ここでonNext(),onErrorのイベントをObservable<Event<Article>>として変換して、
         別々のストリームとして扱えるようにしていて、
         最後のshare()でHotObservablesに変換して一つの入力に対して
         これ以降のobservableがそれぞれ独立したストリームとしてデータ更新を行えるようにしている
         割と大事なのはストリームが閉じなくなる点
         */
        let fetched = viewDidLoadRelay.asObservable().flatMap { dependency.model.fetch().asObservable().materialize()}.share()
        
        //ここなんもわからんけど動いた
        fetched.flatMap { $0.element.map(Observable.just) ?? .empty() }
            .do(onNext: { [self] _ in
                loadingStatusRelay.accept(.loadSuccess)
            })
            .bind(to: articlesRelay)
            .disposed(by: disposeBag)
        
        fetched.flatMap { $0.error.map(Observable.just) ?? .empty() }
            .do(onNext: { [self] _ in
                loadingStatusRelay.accept(.loadFailed)
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    /*
     @Memo
    accept で Relay に .nextイベントを送ることができます。
    Observableの外側からイベントを流すことができるわけです。
    */
    private let viewDidLoadRelay = PublishRelay<Void>()
    func viewDidLoad() {
        viewDidLoadRelay.accept(())
    }
    
    //interfaceとしてアクセスする用
    var input: ArticleListViewModelInput { self }
    var output: ArticleListViewModelOutput { self }
}
