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
    var title: String { get }

    subscript(comment index: Int) -> GistComment { get }
    subscript(file index: Int) -> FileModel { get }
}

internal final class GistDetailDatasource: NSObject, UITableViewDataSource, GistDetailDatasourceProtocol {

    var data: Dynamic<[GistComment]> = Dynamic([])
    var gistModel: GistModel
    var files: [FileModel] {
        return gistModel.files.lazy.map { $0.value }
    }
    var title: String {
        guard let filename = files.first?.filename else {
            return "Shomething happened, check the files: [FileModels]"
        }
        let login = gistModel.owner.login
        return "\(login)/\(filename)"
    }

    enum GistSection: Int {
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
            let row = indexPath.row
            switch gistSection {
            case .gistFiles:
                let fileCell = tableView.dequeueReusableCell(for: indexPath) as FileCell
                fileCell.setup(data: self[file: row])
                return fileCell
            default:
                let commentCell = tableView.dequeueReusableCell(for: indexPath) as CommentTableViewCell
                commentCell.setup(data: self[comment: row])
                return commentCell
            }
        }
        else {
            fatalError("Wrong count, check your data")
        }
    }

    internal subscript(comment index: Int) -> GistComment {
        return data.value[index]
    }

    internal subscript(file index: Int) -> FileModel {
        return files[index]
    }
}
