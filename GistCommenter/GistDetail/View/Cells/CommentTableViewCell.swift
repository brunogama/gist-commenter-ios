//
//  CommentTableViewCell.swift
//  GistCommenter
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Kingfisher
import Reusable
import SwiftDate
import UIKit

internal protocol CommentTableViewCellProtocol: class {

    func setup(data: GistComment)
}

internal final class CommentTableViewCell: UITableViewCell, CommentTableViewCellProtocol, NibReusable {
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var userHandle: UILabel!
    @IBOutlet private weak var timeElapsedLabel: UILabel!
    @IBOutlet private weak var userComment: UITextView!
    private lazy var placeholder: UIImage? = {
        #imageLiteral(resourceName: "user").with(insets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }()

    func setup(data: GistComment) {
        userHandle.text = data.user.login
        userComment.text = data.body
        timeElapsedLabel.text = data.updatedAt.colloquialSinceNow()
        userImageView.kf.setImage(with: data.user.avatarURL, placeholder: placeholder)
    }
}
