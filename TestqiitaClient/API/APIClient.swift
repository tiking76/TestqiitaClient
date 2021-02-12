//
//  APIClient.swift
//  TestqiitaClient
//
//  Created by 舘佳紀 on 2021/02/09.
//  Copyright © 2021 Yoshiki Tachi. All rights reserved.
//

import Alamofire
import Foundation
import RxSwift

struct APIClient {
    private let decoder = JSONDecoder()
    fileprivate let url = URL(string: "https://qiita.com/api/v2/items")
    
    func request() -> Single<[Article]> {
        Single<[Article]>.create{ single in
            AF.request(url!).responseJSON{ response in
                do {
                    let model = try decoder.decode([Article].self, from: response.data!)
                    single(.success(model))
                }
                catch let e{
                    single(.failure(e))
                }
            }
            return Disposables.create()
        }
    }
}

//final class APIGateway {
//    fileprivate let url = URL(string: "https://qiita.com/api/v2/items")
//    static let shared = APIGateway()
//
//    //ここが原因ぽい→意味を為してない気がする
//    func request() -> DataRequest {
//        return AF.request(url!)
//    }
//}

//protocol ArticleListModelProtocol: AnyObject {
//    func fetch() -> Observable<[Article]>
//}
//
//class ArticleListModel : ArticleListModelProtocol {
//    let gateway = APIGateway.shared
//    func fetch() -> Observable<[Article]> {
//        let decoder = JSONDecoder()
//        return Observable.create { [weak self] observer -> Disposable in
//            let request = self?.gateway.request()
//
//            request?.responseJSON{ response in
//                do {
//                    let articleList = try decoder.decode([Article].self, from: response.data!)
//                    observer.onNext(articleList)
//                    observer.onCompleted()
//                }
//                catch let e {
//                    observer.onError(e)
//                }
//            }
//            return Disposables.create() {
//                request?.cancel()
//            }
//        }
//    }
//}
