//
//  UIView+XibSetup.swift
//  GistCommenter
//
//  Created by Bruno Gama on 24/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import UIKit

extension UIView {

    func xibSetup() {
        let view = loadFromNib()
        addSubview(view)
        stretch(view: view)
    }

    func loadFromNib<T: UIView>() -> T {
        let selfType = type(of: self)
        let bundle = Bundle(for: selfType)
        let nibName = String(describing: selfType)
        let nib = UINib(nibName: nibName, bundle: bundle)

        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            fatalError("Error loading nib with name \(nibName)")
        }

        return view
    }

    func stretch(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false

        view.translatesAutoresizingMaskIntoConstraints = false

        ["H:|[childView]|", "V:|[childView]|"].forEach {
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: $0,
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["childView": view])
            )
        }
    }

    fileprivate func constraints(_ visualFormat: String, _ views: [String: Any]) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(withVisualFormat: visualFormat, options: [], metrics: nil, views: views)
    }
}
