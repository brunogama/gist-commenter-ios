//
//  GistModel.swift
//  GistCommenter
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation

// MARK: - GistModel
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

// MARK: - FileModel
internal struct FileModel: Codable, CodableExtension {
    let size: Int
    let rawURL, type, language: String
    let truncated: Bool
    let content: String

    enum CodingKeys: String, CodingKey {
        case size
        case rawURL = "raw_url"
        case type, language, truncated, content
    }
}

// MARK: - Fork
internal struct ForkModel: Codable, CodableExtension {
    let user: UserModel
    let url, id, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case user, url, id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - User
internal struct UserModel: Codable, CodableExtension {
    let login: String
    let id: Int
    let avatarURL, gravatarID, url, htmlURL: String
    let followersURL, followingURL, gistsURL, starredURL: String
    let subscriptionsURL, organizationsURL, reposURL, eventsURL: String
    let receivedEventsURL, type: String
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
}

// MARK: - History
internal struct HistoryModel: Codable, CodableExtension {
    let url, version: String
    let user: UserModel
    let changeStatus: ChangeStatus
    let committedAt: String

    enum CodingKeys: String, CodingKey {
        case url, version, user
        case changeStatus = "change_status"
        case committedAt = "committed_at"
    }
}

internal struct ChangeStatus: Codable, CodableExtension {
    let deletions, additions, total: Int
}
