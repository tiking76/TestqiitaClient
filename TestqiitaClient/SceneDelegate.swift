//
//  SceneDelegate.swift
//  TestqiitaClient
//
//  Created by 舘佳紀 on 2020/08/13.
//  Copyright © 2020 Yoshiki Tachi. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let model = ArticleListModel(apiClient: APIClient())
        let viewModel = ArticleListViewModel(dependency: ArticleListViewModel.Dependency(model: model))
        window?.rootViewController = ArticleListViewController(viewModel: viewModel)
        window?.makeKeyAndVisible()
    }
}

