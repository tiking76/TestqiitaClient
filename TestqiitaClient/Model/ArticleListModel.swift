//
//  ArticleListAPIClient.swift
//  TestqiitaClient
//
//  Created by 舘佳紀 on 2020/08/14.
//  Copyright © 2020 Yoshiki Tachi. All rights reserved.
//

import RxSwift

protocol ArticleListModelProtocol {
    var apiClient: APIClient { get }
    
    func fetch() -> Single<[Article]>
}

struct ArticleListModel: ArticleListModelProtocol {
    var apiClient = APIClient()
    
    func fetch() -> Single<[Article]> {
        return apiClient.request()
    }
}
