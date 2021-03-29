//
//  AppDelegate.swift
//  FoodTracker
//
//  Created by kudo koki on 2021/03/29.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    //1 アプリ起動時に実行
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle
    //2　シーン起動時に実行。シーンの構成を指定している。
    // シーンとは、画面に表示する内容を表すエリアのこと。
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    //E2　シーン終了時に実行。sceneDidDisconnectとの違いがようわからん。
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

