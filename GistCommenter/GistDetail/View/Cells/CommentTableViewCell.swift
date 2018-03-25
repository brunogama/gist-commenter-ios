//
//  CommentTableViewCell.swift
//  GistCommenter
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Reusable
import SwiftDate
import UIKit

internal protocol CommentTableViewCellProtocol: class {

    func setup(data: GistComment)
}

internal final class CommentTableViewCell: UITableViewCell, CommentTableViewCellProtocol, NibReusable {
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var userHandle: UILabel!
    @IBOutlet weak var timeElapsedLabel: UILabel!
    @IBOutlet private weak var userComment: UITextView!

    func setup(data: GistComment) {
        userHandle.text = data.user.login
        userComment.text = data.body
        timeElapsedLabel.text = data.updatedAt.colloquialSinceNow()
    }
}
