//
//  AppDelegate.swift
//  GistCommenter
//
//  Created by Bruno Gama on 20/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import CoreData
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

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also
        // applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "GistCommenter")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this
                // function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is
                 * locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            }
            catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this
                // function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
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
