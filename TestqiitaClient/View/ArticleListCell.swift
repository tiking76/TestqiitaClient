//
//  ArticleListCell.swift
//  TestqiitaClient
//
//  Created by 舘佳紀 on 2020/08/19.
//  Copyright © 2020 Yoshiki Tachi. All rights reserved.
//

import UIKit



class ArticleListCell : UITableViewCell {
    
    static let reuseIdentifier = "ArticleListCell"
    
    let titleLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8.0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0).isActive = true
    }
    
    func configure(title : String) {
        titleLabel.text = title
    }
}
