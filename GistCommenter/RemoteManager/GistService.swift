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
    case gist(gistId: String), comments(gistId: String)

    // MARK: TargetType
    // swiftlint:disable force_unwrapping
    var baseURL: URL { return URL(string: "https://api.github.com")! }
    // swiftlint:enable force_unwrapping

    var path: String { return "/gists" }

    var method: Moya.Method { return .get }

    var sampleData: Data {
        var fileName = ""
        switch self {
        case .gist:
            fileName = "gist"
        default:
            fileName = "comments"
        }

        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                return Data()
        }
        return data
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String: String]? { return nil }

}
