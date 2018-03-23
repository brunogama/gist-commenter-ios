//
//  ViewControllerBootstrapper.swift
//  GistCommenterTests
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import UIKit
import XCTest

internal final class ViewControllerBootstrapper<T: UIViewController> {

    // swiftlint:disable implicitly_unwrapped_optional
    private var rootWindow: UIWindow!
    // swiftlint:enable implicitly_unwrapped_optional

    func setupTopLevelUI(withViewController viewController: T) {
        rootWindow = UIWindow(frame: UIScreen.main.bounds)
        rootWindow.isHidden = false
        rootWindow.rootViewController = viewController
        _ = viewController.view
        viewController.viewWillAppear(false)
        viewController.viewDidAppear(false)
    }

    func tearDownTopLevelUI() {
        guard let rootWindow = rootWindow,
              let rootViewController = rootWindow.rootViewController as? T else {
                XCTFail("tearDownTopLevelUI() was called without setupTopLevelUI() being called first")
                return
        }
        rootViewController.viewWillDisappear(false)
        rootViewController.viewDidDisappear(false)
        rootWindow.rootViewController = nil
        rootWindow.isHidden = true
        self.rootWindow = nil
    }
}
