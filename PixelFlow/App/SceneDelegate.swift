//
//  SceneDelegate.swift
//  PixelFlow
//
//  Created by Елизавета on 03.04.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    static let main: SceneDelegate? = { UIApplication.shared.delegate as? SceneDelegate }()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        self.window = window

        let dataStoreManager = CoreDataDataStoreManager()

        if StorageManager.getMainBoardName() == "" {
            let _ = dataStoreManager.intitBoard()
        }

        window.rootViewController = PixelSheetController()
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }


}

