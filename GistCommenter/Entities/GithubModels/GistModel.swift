//
//  GistModel.swift
//  GistCommenter
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation

internal struct GistModel: Codable, CodableExtension {
    let url, forksURL, commitsURL, id: String
    let description: String
    let purplePublic: Bool
    let owner: UserModel
    let user: JSONNull?
    let files: [String: FileModel]
    let truncated: Bool
    let comments: Int
    let commentsURL, htmlURL, gitPullURL, gitPushURL: String
    let createdAt, updatedAt: String
    let forks: [ForkModel]
    let history: [HistoryModel]

    enum CodingKeys: String, CodingKey {
        case url
        case forksURL = "forks_url"
        case commitsURL = "commits_url"
        case id, description
        case purplePublic = "public"
        case owner, user, files, truncated, comments
        case commentsURL = "comments_url"
        case htmlURL = "html_url"
        case gitPullURL = "git_pull_url"
        case gitPushURL = "git_push_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case forks, history
    }
}
