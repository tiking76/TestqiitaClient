//
//  ArticleListViewModel.swift
//  TestqiitaClient
//
//  Created by 舘佳紀 on 2021/02/09.
//  Copyright © 2021 Yoshiki Tachi. All rights reserved.
//

import RxSwift
import RxRelay

struct ArticleListViewModel {
    
    struct Dependency {
        let model = ArticleListModel()
    }
    
    struct Output {
        let articles = BehaviorRelay<[Article]>(value: [])
    }
    
    let disposeBeg = DisposeBag()
    let dependency: Dependency
    let output = Output()
    
    func fetch() {
        Dependency.init().model.fetch()
            .asObservable()
            .subscribe(onNext: { list in
                print(list)
                print("hoge")
                output.articles.accept(list)
            })
            .disposed(by: disposeBeg)
    }
}
