//
//  GistService+Method.swift
//  GistCommenter
//
//  Created by Bruno Gama on 26/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation
import Moya

extension GistService {
    var method: Moya.Method {
        switch self {
        case .sendComment:
            return .post
        default:
            return .get
        }
    }
}
