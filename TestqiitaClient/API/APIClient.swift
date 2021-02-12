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
