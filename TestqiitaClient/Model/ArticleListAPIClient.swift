//
//  ArticleListAPIClient.swift
//  TestqiitaClient
//
//  Created by 舘佳紀 on 2020/08/14.
//  Copyright © 2020 Yoshiki Tachi. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

protocol ArticleListModelProtocol {
    func featch() -> Observable<[Article]>
}

class ArticleListModel : ArticleListModelProtocol {
    let gateway = APIGateway.shared
    func featch() -> Observable<[Article]> {
        let decoder = JSONDecoder()
        return Observable.create { [weak self] observer -> Disposable in
            let request = self?.gateway.request()
            
            request?.responseJSON{ response in
                do {
                    let articleList = try decoder.decode([Article].self, from: response.data!)
                    observer.onNext(articleList)
                    observer.onCompleted()
                }
                catch let e {
                    observer.onError(e)
                }
            }
            return Disposables.create() {
                request?.cancel()
            }
        }
    }
}
