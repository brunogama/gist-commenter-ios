//
//  UIViewController+NibLoadable.swift
//  GistCommenter
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import UIKit

internal protocol NibIdentifiable {
    static var nibNameIdentifier: String { get }
}

// MARK: - Indentifies each storyboard from its classname.
extension NibIdentifiable where Self: UIViewController {
    static var nibNameIdentifier: String {
        return String(describing: self)
    }

    static func instantiate(_ bundle: Bundle? = nil) -> Self {
        return self.init(nibName: self.nibNameIdentifier, bundle: bundle)
    }

}

extension UIViewController: NibIdentifiable {}
