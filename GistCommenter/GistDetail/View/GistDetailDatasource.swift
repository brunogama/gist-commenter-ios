//
//  GistDetailDatasource.swift
//  GistCommenter
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation
import UIKit

internal protocol GistDetailDatasourceProtocol: class {
    typealias GistDataCallback = ([GistComment]) -> Void

    var data: Dynamic<[GistComment]> { get set }
    var gistModel: GistModel { get }
}

internal final class GistDetailDatasource: NSObject, UITableViewDataSource, GistDetailDatasourceProtocol {

    var data: Dynamic<[GistComment]> = Dynamic([])
    var gistModel: GistModel

    private enum GistSection: Int {
        case gistFiles = 0
        case comments

        init?(indexPath: IndexPath) {
            self.init(rawValue: indexPath.section)
        }

        static var numberOfSections: Int { return 2 }
    }

    init(gistModel: GistModel) {
        self.gistModel = gistModel
        super.init()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return GistSection.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let gistSection = GistSection(rawValue: section) {
            switch gistSection {
            case .gistFiles:
                return gistModel.files.count
            default:
                return data.value.count
            }
        }
        else {
            fatalError("Wrong count, check your data")
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let gistSection = GistSection(indexPath: indexPath) {
            switch gistSection {
            case .gistFiles:
                return UITableViewCell()
            default:
                let commentCell = tableView.dequeueReusableCell(for: indexPath) as GistCommentTableViewCell
                commentCell.setup(data: data.value[indexPath.row])
                return commentCell
            }
        }
        else {
            fatalError("Wrong count, check your data")
        }
    }

}
