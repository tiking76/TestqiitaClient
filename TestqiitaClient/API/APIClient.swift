//
//  APIClient.swift
//  TestqiitaClient
//
//  Created by 舘佳紀 on 2021/02/09.
//  Copyright © 2021 Yoshiki Tachi. All rights reserved.
//

import Alamofire
import Foundation

final class APIGateway {
    fileprivate let url = URL(string: "https://qiita.com/api/v2/items")
    static let shared = APIGateway()
    
    //ここが原因ぽい→意味を為してない気がする
    func request() -> DataRequest {
        return AF.request(url!)
    }
}
