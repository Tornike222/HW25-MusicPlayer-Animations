//
//  SceneDelegate.swift
//  MusicPlayerApp
//
//  Created by telkanishvili on 09.05.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let navigationController = UINavigationController(rootViewController: MusicPlayerViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
}
