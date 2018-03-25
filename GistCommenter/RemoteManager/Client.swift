//
//  Client.swift
//  GistCommenter
//
//  Created by Bruno Gama on 24/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation
import Moya

internal enum RemoteDataManagerError: Error {
    case parseError, invalidStatusCode(Int), other(NSError)
}

internal protocol RemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: RemoteDataManagerOutputProtocol? { get set }

    func retriveGist(with gistId: GistId)
    func retriveComments(with gistId: GistId)
}

internal protocol RemoteDataManagerOutputProtocol: class {

    func onGistRetrieved(_ gist: GistModel)
    func onGistRetrievalFailure(_ error: Error)

    func onCommentsRetrieved(_ comments: [GistComment])
    func onCommentsRetrievalFailure(_ error: Error)
}

internal final class Client: RemoteDataManagerInputProtocol {
    private(set) var provider: MoyaProvider<GistService>?
    var remoteRequestHandler: RemoteDataManagerOutputProtocol?

    init?(provider: MoyaProvider<GistService>?) {
        self.provider = provider
    }

    func retriveGist(with gistId: GistId) {
        provider?.request(.gist(gistId: gistId)) { result in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200 ... 300:
                    guard let gistModel = GistModel(data: response.data) else {
                        self.remoteRequestHandler?.onGistRetrievalFailure(RemoteDataManagerError.parseError)
                        return
                    }

                    self.remoteRequestHandler?.onGistRetrieved(gistModel)

                default:
                    self.remoteRequestHandler?
                        .onGistRetrievalFailure(RemoteDataManagerError.invalidStatusCode(response.statusCode))
                }

            case let .failure(error):
                self.remoteRequestHandler?.onGistRetrievalFailure(error)
            }
        }
    }

    func retriveComments(with gistId: GistId) {
        provider?.request(.comments(gistId: gistId)) { result in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200 ... 300:
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    guard let comments = try? decoder.decode([GistComment].self, from: response.data) else {
                        self.remoteRequestHandler?.onCommentsRetrievalFailure(RemoteDataManagerError.parseError)
                        return
                    }

                    self.remoteRequestHandler?.onCommentsRetrieved(comments)

                default:
                    self.remoteRequestHandler?
                        .onCommentsRetrievalFailure(RemoteDataManagerError.invalidStatusCode(response.statusCode))
                }

            case let .failure(error):
                self.remoteRequestHandler?.onCommentsRetrievalFailure(error)
            }
        }
    }
}
