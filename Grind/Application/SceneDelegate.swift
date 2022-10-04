//
//  SceneDelegate.swift
//  Grind
//
//  Created by 최형민 on 2022/09/13.
//

import UIKit
import HealthKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let homeViewController = HomeViewController()
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        
        let statViewController = StatViewController()
        let statNavigationController = UINavigationController(rootViewController: statViewController)
        
        let settingViewController = SettingViewController()
        let settingNavigationController = UINavigationController(rootViewController: settingViewController)
        
        let tabBarController = UITabBarController()
        
        tabBarController.setViewControllers([statNavigationController, homeNavigationController, settingNavigationController], animated: true)
        tabBarController.tabBar.tintColor = Constants.Color.primaryText
        
        if let items = tabBarController.tabBar.items {
            items[0].selectedImage = UIImage(systemName: "waveform.path.ecg.rectangle.fill")
            items[0].image = UIImage(systemName: "waveform.path.ecg.rectangle")
            items[0].title = "통계"
            items[0].setTitleTextAttributes([NSAttributedString.Key.font: Constants.Font.textFont as Any], for: .normal)
            
            items[1].selectedImage = UIImage(systemName: "house.fill")
            items[1].image = UIImage(systemName: "house")
            items[1].title = "홈"
            items[1].setTitleTextAttributes([NSAttributedString.Key.font: Constants.Font.textFont as Any], for: .normal)
            
            items[2].selectedImage = UIImage(systemName: "gearshape.fill")
            items[2].image = UIImage(systemName: "gearshape")
            items[2].title = "설정"
            items[2].setTitleTextAttributes([NSAttributedString.Key.font: Constants.Font.textFont as Any], for: .normal)
        }
        
        // 홈 탭을 기본 탭으로 설정
        tabBarController.selectedViewController = homeNavigationController
        tabBarController.tabBar.backgroundColor = Constants.Color.backgroundColor
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

