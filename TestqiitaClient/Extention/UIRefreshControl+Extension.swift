//
//  UIRefreshControl+Extension.swift
//  TestqiitaClient
//
//  Created by 舘佳紀 on 2021/02/13.
//  Copyright © 2021 Yoshiki Tachi. All rights reserved.
//

import RxCocoa
import RxSwift

extension Reactive where Base: UIRefreshControl {
    var endRefreshing: Binder<Void> {
        Binder(self.base) { base, _ in
            if base.isRefreshing {
                base.endRefreshing()
            }
        }
    }
}
