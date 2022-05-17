//
//  SceneDelegate.swift
//  Final_Project
//
//  Created by tri.nguyen on 17/05/2022.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        let tabbarVC = BaseTabbarViewController()
        window.rootViewController = tabbarVC
        window.makeKeyAndVisible()
    }
}

