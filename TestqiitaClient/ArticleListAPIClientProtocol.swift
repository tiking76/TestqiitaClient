//
//  ArticleAPIClientProtocol.swift
//  TestqiitaClient
//
//  Created by 舘佳紀 on 2020/08/14.
//  Copyright © 2020 Yoshiki Tachi. All rights reserved.
//

import Foundation

protocol ArticleListAPIClientProtocol {
    func featch(completion: @escaping (([Article]?) -> Void))
}
