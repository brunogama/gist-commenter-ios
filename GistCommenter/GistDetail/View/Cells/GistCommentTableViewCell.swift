//
//  GistCommentTableViewCell.swift
//  GistCommenter
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Reusable
import UIKit

internal protocol GistCommentTableViewCellProtocol: class {

    func setup(data: GistComment)
}

internal final class GistCommentTableViewCell: UITableViewCell, GistCommentTableViewCellProtocol, NibReusable {
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var userHandle: UILabel!
    @IBOutlet private weak var userComment: UITextView!

    func setup(data: GistComment) {
        userHandle.text = data.user.login
        userComment.text = data.body
    }
}
