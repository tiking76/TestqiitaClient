//
//  ArticleListViewController.swift
//  TestqiitaClient
//
//  Created by 舘佳紀 on 2020/08/13.
//  Copyright © 2020 Yoshiki Tachi. All rights reserved.
//

import UIKit

class ArticleListViewController: UIViewController {
    
    let titleLabel = UILabel()
    let tableView = UITableView()

    let client : ArticleListAPIClientProtocol
    
    init(client: ArticleListAPIClientProtocol = ArticleListAPIClient()) {
          self.client = client
          
          super.init(nibName: nil, bundle: nil)
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        
        client.featch { [weak self] (articleList) in
            guard let articleList = articleList, 0 < articleList.count else { return }
            
            self?.titleLabel.text = articleList[0].title
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
