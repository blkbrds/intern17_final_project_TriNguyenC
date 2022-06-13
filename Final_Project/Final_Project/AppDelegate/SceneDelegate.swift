//
//  SceneDelegate.swift
//  Final_Project
//
//  Created by tri.nguyen on 17/05/2022.
//

import UIKit

enum RootType {
    case splash, top
}

var sceneDelegate: SceneDelegate? {
    
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
        let delegate = windowScene.delegate as? SceneDelegate else { return nil }
     return delegate
}

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window = self.window
        }
        swapRoot(.splash)
    }

    func swapRoot(_ rootType: RootType) {
        guard let window = window else { return }
        switch rootType {
        case .splash:
            let splashVC = SplashViewController()
            let navigation = BaseNavigationViewController(rootViewController: splashVC)
            window.rootViewController = navigation
        case .top:
            let tabbarVC = BaseTabbarViewController()
            window.rootViewController = tabbarVC
        }
        window.makeKeyAndVisible()
    }
}
