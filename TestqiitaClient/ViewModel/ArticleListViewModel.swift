//
//  ArticleListViewModel.swift
//  TestqiitaClient
//
//  Created by 舘佳紀 on 2021/02/09.
//  Copyright © 2021 Yoshiki Tachi. All rights reserved.
//

import RxSwift
import RxCocoa

final class ArticleListViewModel {
    private let disposeBeg = DisposeBag()
    private let model: ArticleListModelProtocol
    
    // commpacted value
    var articles: [Article] { return _articles.value }
    
    //value
    private let _articles = BehaviorRelay<[Article]>(value: [])
    
    let reloadData: Observable<Void>
    
    init() {
        reloadData.asObservable()
    }
}
