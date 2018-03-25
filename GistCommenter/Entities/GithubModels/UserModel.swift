//
//  UserModel.swift
//  GistCommenter
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation

internal struct UserModel: Codable, CodableExtension {
    let avatarURL: URL
    let followersURL: URL
    let followingURL: String
    let gistsURL: String
    let gravatarID: String
    let htmlURL: URL
    let id: Int
    let login: String
    let organizationsURL: URL
    let receivedEventsURL: URL
    let reposURL: URL
    let siteAdmin: Bool
    let starredURL: String
    let subscriptionsURL: URL
    let type: String
    let url: URL

    enum CodingKeys: String, CodingKey {
        case login, id, type, url
        case avatarURL = "avatar_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case gravatarID = "gravatar_id"
        case htmlURL = "html_url"
        case organizationsURL = "organizations_url"
        case receivedEventsURL = "received_events_url"
        case reposURL = "repos_url"
        case siteAdmin = "site_admin"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
    }
}
