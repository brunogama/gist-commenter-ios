//
//  GistService.swift
//  GistCommenter
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation
import Moya

internal enum GistService: TargetType {
    case gist(gistId: String)
    case comments(gistId: String)

    // MARK: TargetType
    var method: Moya.Method { return .get }
    var headers: [String: String]? { return nil }
}
