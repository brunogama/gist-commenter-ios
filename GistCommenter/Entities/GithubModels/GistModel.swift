//
//  GistModel.swift
//  GistCommenter
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation

internal typealias GistId = String

internal struct GistModel: Codable, CodableExtension {
    let comments: Int
    let commentsURL: URL
    let commitsURL: URL
    let createdAt, updatedAt: Date
    let description: String
    let files: [String: FileModel]
    let forks: [ForkModel]
    let forksURL: URL
    let gitPullURL: URL
    let gitPushURL: URL
    let history: [HistoryModel]
    let htmlURL: URL
    let id: GistId
    let owner: UserModel
    let purplePublic: Bool
    let truncated: Bool
    let url: URL
    let user: UserModel?

    enum CodingKeys: String, CodingKey {
        case comments, files, forks, history, id, description, owner, truncated, url, user
        case commentsURL = "comments_url"
        case commitsURL = "commits_url"
        case createdAt = "created_at"
        case forksURL = "forks_url"
        case gitPullURL = "git_pull_url"
        case gitPushURL = "git_push_url"
        case htmlURL = "html_url"
        case purplePublic = "public"
        case updatedAt = "updated_at"
    }
}
