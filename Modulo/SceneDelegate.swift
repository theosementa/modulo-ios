//
//  SceneDelegate.swift
//  Modulo
//
//  Created by Theo Sementa on 31/03/2026.
//

import UIKit
import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = ModuloWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: RootScreen())
        window.makeKeyAndVisible()
        self.window = window
    }

}
