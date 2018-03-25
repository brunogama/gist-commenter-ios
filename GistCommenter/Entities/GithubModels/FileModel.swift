//
//  FileModel.swift
//  GistCommenter
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation

internal struct FileModel: Codable, CodableExtension {
    let size: Int
    let rawURL, type, filename, language: String
    let truncated: Bool
    let content: String

    enum CodingKeys: String, CodingKey {
        case size
        case rawURL = "raw_url"
        case type, language, truncated, content, filename
    }
}
