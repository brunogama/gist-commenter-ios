//
//  AlertController+Extensions.swift
//  GistCommenter
//
//  Created by Bruno Gama on 27/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import UIKit

internal extension UIAlertController {
    static func loading(_ title: String) -> UIAlertController {
        let alert = UIAlertController(title: title,
                                      message: nil,
                                      preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        alert.view.addSubview(indicator)
        indicator.isUserInteractionEnabled = false
        indicator.startAnimating()

        return alert
    }
}
