//
//  GistService+TargetType.path.swift
//  GistCommenter
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation
import Moya

extension GistService {
    var path: String {
        switch self {
        case let .gist(gistId):
            return "/gists/\(gistId)"
        case let .comments(gistId):
            return "/gists/\(gistId)/comments"
        }
    }
}
