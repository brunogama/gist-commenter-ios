//
//  FileCell.swift
//  GistCommenter
//
//  Created by Bruno Gama on 24/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Reusable
import UIKit

internal protocol FileCellProtocol: class {
    func setup(data: FileModel)
}

public final class FileCell: UITableViewCell, NibReusable, FileCellProtocol {
    @IBOutlet private weak var fileLabel: UILabel!

    func setup(data: FileModel) {
        self.fileLabel.text = data.filename
    }
}
