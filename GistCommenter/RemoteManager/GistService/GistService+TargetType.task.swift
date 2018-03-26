//
//  GistService+TargetType.task.swift
//  GistCommenter
//
//  Created by Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation
import Moya

extension GistService {
    var task: Task {
        switch self {
            //        case .gist:
        //            return .requestJSONEncodable(GistModel.self)
        default:
            return .requestPlain
            //            return .requestJSONEncodable([GistComment.self])
        }
    }
}
