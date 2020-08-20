//
//  ArticleListAPIClient.swift
//  TestqiitaClient
//
//  Created by 舘佳紀 on 2020/08/14.
//  Copyright © 2020 Yoshiki Tachi. All rights reserved.
//

import Foundation

class ArticleListAPIClient : ArticleListAPIClientProtocol {
    func featch(completion: @escaping (([Article]?) -> Void)) {
        guard let url = URL(string: "https://qiita.com/api/v2/items") else { return }
        let reauest = URLRequest(url: url)
        URLSession.shared.dataTask(with: reauest) { (data, response, error) in
            guard let data = data else { return }
            
            let articleList = try? JSONDecoder().decode([Article].self, from: data)
            DispatchQueue.main.async {
                completion(articleList)
            }
        }.resume()
    }
}
