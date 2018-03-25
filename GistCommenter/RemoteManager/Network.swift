//
//  Network.swift
//  GistCommenter
//
//  Created by Bruno Gama on 24/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation
import Moya

//        guard let substring = URLComponents(url: url, resolvingAgainstBaseURL: true)?
//            .path
//            .split(separator: "/")
//            .last else {
//                Logger.e("Failed to parse gist id")
//                return
//        }
//
//        let gistId = String(substring)

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
    func onGistRetrieveFailure(_ error: Error)
}

internal final class Network: RemoteDataManagerInputProtocol {
    private(set) var provider: MoyaProvider<GistService>?
    var remoteRequestHandler: RemoteDataManagerOutputProtocol?

    init?(provider: MoyaProvider<GistService>) {
        self.provider = provider
    }

    func retriveGist(with gistId: GistId) {
        provider?.request(.gist(gistId: gistId)) { result in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200 ... 300:
                    guard let gistModel = GistModel(data: response.data) else {
                        self.remoteRequestHandler?.onGistRetrieveFailure(RemoteDataManagerError.parseError)
                        return
                    }

                    self.remoteRequestHandler?.onGistRetrieved(gistModel)

                default:
                    self.remoteRequestHandler?
                        .onGistRetrieveFailure(RemoteDataManagerError.invalidStatusCode(response.statusCode))
                }

            case let .failure(error):
                self.remoteRequestHandler?.onGistRetrieveFailure(error)
            }
        }
    }

    func retriveComments(with gistId: GistId) {
    }
}
