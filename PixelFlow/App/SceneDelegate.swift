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
        window.rootViewController = PixelSheetController()
        window.makeKeyAndVisible()
        
        let dataStoreManager = DataStoreManager()

            // dataStoreManager.fetchDays()
       // dataStoreManager.deletedays()
      //  dataStoreManager.deleteAll()
//        if let boards = dataStoreManager.fetchBoars() {
//            window.rootViewController = PixelSheetController(boards: [Board(name: "bgc", colorSheme: .base, parameters: [BoardParameter(name: "bgf", color: "black")], notifications: [NotificationSetting(time: "20:00", isOn: true)])])
//            window.makeKeyAndVisible()
//        } else {
//            dataStoreManager.intitBoard()
//            if let boards = dataStoreManager.fetchBoars() {
//                window.rootViewController = PixelSheetController(boards: [Board(name: "bgc", colorSheme: .base, parameters: [BoardParameter(name: "bgf", color: "black")], notifications: [NotificationSetting(time: "20:00", isOn: true)])])
//                window.makeKeyAndVisible()
//            } else {
//                fatalError("База пиздык")
//            }
//        }

//        man.intitBoard()
//    //    man.deleteAll()
//        man.fetchBoars()
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
     //   (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

