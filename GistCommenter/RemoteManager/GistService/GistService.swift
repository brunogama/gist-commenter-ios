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
    typealias Credentials = (username: String, password: String)
//    typealias ParseTarget = (Data) -> T?

    case createTokenFor(credentials: Credentials)
    case comments(gistId: GistId)
    case gist(gistId: GistId)
    case sendComment(gistId: GistId, message: String)

    // MARK: TargetType

    var baseURL: URL { return AppSettings.Api.baseUrl }

    var method: Moya.Method {
        switch self {
        case .createTokenFor, .sendComment:
            return .post
        case .comments, .gist:
            return .get
        }
    }

    var task: Task {
        let encoding: ParameterEncoding
        switch self.method {
        case .delete, .put, .post, .patch:
            encoding = JSONEncoding.default
        default:
            encoding = URLEncoding.default
        }
        if let requestParameters = parameters {

            return .requestParameters(parameters: requestParameters, encoding: encoding)
        }
        return .requestPlain
    }

    var parameters: [String: Any]? {
        switch self {
        case .createTokenFor:
            return [
                "client_id": AppSettings.Api.key,
                "client_secret": AppSettings.Api.secret,
                "fingerprint": UUID().uuidString,
                "scopes": ["gist"]
            ]
        case .gist, .comments:
            return nil
        case .sendComment(_, let message):
            return ["body": message]
        }
    }

    var headers: [String: String]? {
        let header = ["Accept": "application/vnd.github.v3+json"]
        switch self {
        case .createTokenFor(let credentials):
            guard let encoded = "\(credentials.username):\(credentials.password)".base64Encoded() else {
                return nil
            }
            return ["Authorization": "Basic \(encoded)"]
        case .sendComment:
            let sendHeaders = [
                "Authorization": "token \(AppSettings.Keys.token!)",
                "User-Agent": "qr-code-gist-comments"
            ]

            return header.merging(sendHeaders, uniquingKeysWith: { first, _ -> String in
                first
            })

        case .comments, .gist:
            return nil
        }
    }

    var sampleData: Data {
        switch self {
        case .gist:
            return stubbedResponse("gist")
        case .comments:
            return stubbedResponse("comments")
        case .createTokenFor, .sendComment:
            return stubbedResponse("fail")
        }
    }

    var path: String {
        switch self {
        case .createTokenFor:
            return "/authorizations"
        case let .gist(gistId):
            return "/gists/\(gistId)"
        case .comments(let gistId), .sendComment(let gistId, _):
            return "/gists/\(gistId)/comments"
        }
    }
}

// swiftlint:disable force_unwrapping
internal func stubbedResponse(_ filename: String) -> Data! {
    @objc class TestClass: NSObject { }

    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

internal func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}

extension String {
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }

    func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
// swiftlint:enable force_unwrapping
