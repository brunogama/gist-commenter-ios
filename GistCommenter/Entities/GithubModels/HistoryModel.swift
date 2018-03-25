//
//  HistoryModel.swift
//  GistCommenter
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation

internal struct HistoryModel: Codable, CodableExtension {
    let changeStatus: ChangeStatusModel
    let committedAt: Date
    let url: String
    let user: UserModel
    let version: String

    enum CodingKeys: String, CodingKey {
        case url, user, version
        case changeStatus = "change_status"
        case committedAt = "committed_at"
    }
}
