//
//  GistComment.swift
//  GistCommenter
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation

internal struct GistComment: Codable, CodableExtension {
    let id: Int
    let url, body: String
    let user: UserModel
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, url, body, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
