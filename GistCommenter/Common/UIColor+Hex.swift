//
//  UIColor+Hex.swift
//  GistCommenter
//
//  Created by Bruno Gama on 24/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(rgb: UInt32) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}
