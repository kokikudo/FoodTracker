//
//  SceneDelegate.swift
//  FoodTracker
//
//  Created by kudo koki on 2021/03/29.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // 全てのコンテンツが描画されている場所
    var window: UIWindow?

    //3 windowプロパティが初期化され、シーンに添付される。
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        print("scene")
    }
    //E1　シーンがバックグラウンドに入った直後や、セッションが破棄されたときに実行
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        print("sceneDidDisconnect")
    }
    //6 F2
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        print("アプリが開いた時に実行します")
    }
    //B1　一時的な中断（例：電話の着信）により発生する。
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        print("アプリが閉じそうな時に実行します")
    }
    //5 F1　シーンがバックグラウンドからフォアグラウンドに移動する時に実行
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        print("アプリが開きそうな時に実行します")
    }
    //B2
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        print("アプリが閉じた時に実行します")
    }


}

