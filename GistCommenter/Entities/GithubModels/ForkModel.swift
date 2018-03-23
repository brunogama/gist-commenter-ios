//
//  ForkModel.swift
//  GistCommenter
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation

internal struct ForkModel: Codable, CodableExtension {
    let user: UserModel
    let url, id, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case user, url, id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
