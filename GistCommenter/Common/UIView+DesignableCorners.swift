//
//  UIView+DesignableCorners.swift
//  GistCommenter
//
//  Created by Bruno Gama on 25/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import UIKit

extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            if let cgColor = layer.borderColor {
                return  UIColor(cgColor: cgColor)
            }
            return nil
        }
        set {
            layer.borderColor = borderColor?.cgColor
        }
    }
}
