//
//  GistHeaderView.swift
//  GistCommenter
//
//  Created by Bruno Gama on 25/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Reusable
import UIKit

internal protocol GistHeaderViewProtocol: class {
    var title: String? { get set }
}

internal final class GistHeaderView: UIView, NibOwnerLoadable {

    @IBOutlet private weak var descriptionLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNibContent()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    var title: String? {
        didSet {
            self.descriptionLabel.text = title
        }
    }
}
