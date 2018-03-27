//
//  AppDelegate.swift
//  GistCommenter
//
//  Created by Bruno Gama on 20/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Moya
import UIKit

@UIApplicationMain
internal class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.prefersLargeTitles = false
        return navigationController
    }()

    public func application(_ application: UIApplication,
                            didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        navigationController.pushViewController(QRCodeReaderRouter.createModule(), animated: true)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        appearanceSetup()
        return true
    }

    // MARK: - Private methods
    fileprivate func appearanceSetup() {
        UINavigationBar.appearance().barTintColor = Asset.Colors.black.color
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).textColor = .white
    }
}

extension UINavigationController {
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        if let style = self.topViewController?.preferredStatusBarStyle { return style }
        return .lightContent
    }
}
