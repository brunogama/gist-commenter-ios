//
//  GistComment.swift
//  GistCommenter
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation

internal struct GistComment: Codable, CodableExtension {
    let body: String
    let createdAt: Date
    let id: Int
    let updatedAt: Date
    let url: String
    let user: UserModel

    enum CodingKeys: String, CodingKey {
        case body, id, url, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
