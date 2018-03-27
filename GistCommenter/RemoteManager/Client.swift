//
//  Client.swift
//  GistCommenter
//
//  Created by Bruno Gama on 24/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation
import Moya
import Result

internal enum RemoteDataManagerError: Error {
    case parseError, invalidStatusCode(Int), other(NSError)
}

internal protocol RemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: RemoteDataManagerOutputProtocol? { get set }

    func retriveGist(with gistId: GistId)

    func retriveComments(with gistId: GistId)

    func send(message: String,
              forGist id: GistId,
              completion: @escaping (Result<GistComment, RemoteDataManagerError>) -> Void)

    func retrieveToken(forUsername: String,
                       with password: String,
                       completion: @escaping (Result<String, RemoteDataManagerError>) -> Void)
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
    var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    func request(
        _ target: GistService,
        success successCallback: @escaping (Data) -> Void,
        error errorCallback: @escaping (RemoteDataManagerError) -> Void,
        failure failureCallback: @escaping (MoyaError) -> Void
        ) {

        provider?.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    successCallback(response.data)
                }
                catch {
                    errorCallback(.invalidStatusCode(response.statusCode))
                }

            case let .failure(error):
                failureCallback(error)
            }
        }
    }

    init?(provider: MoyaProvider<GistService>?) {
        self.provider = provider
    }

    func send(message: String,
              forGist id: GistId,
              completion: @escaping (Result<GistComment, RemoteDataManagerError>) -> Void
        ) {
        let target: GistService = .sendComment(gistId: id, message: message)
        self.request(target, success: { data in
            completion(.success(GistComment(data: data)!))
        }, error: { error in
            completion(.failure(error))
        }, failure: { _ in
            let error = RemoteDataManagerError.other(NSError(domain: "Critical failure sending message", code: -1,
                                                             userInfo: nil))
            completion(.failure(error))
        })
    }

    func retrieveToken(
        forUsername: String,
        with password: String,
        completion: @escaping (Result<String, RemoteDataManagerError>) -> Void
        ) {
        let credentials: GistService.Credentials = (forUsername, password)
        let target: GistService = .createTokenFor(credentials: credentials)
        self.request(target, success: { data in
            guard let decoded = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let hashedToken = decoded?["token"] as? String else {
                fatalError("Serialization failed or hashed_token key not present")
            }
            AppSettings.Keys.save(token: hashedToken)
            completion(.success(hashedToken))
        }, error: { error in
            completion(.failure(error))
        }, failure: { _ in
            let error = RemoteDataManagerError.other(NSError(domain: "Critical failure retrieving token", code: -1,
                                                             userInfo: nil))
            completion(.failure(error))
        })
    }

    func retriveGist(with gistId: GistId) {
        self.request(.gist(gistId: gistId), success: { data in
            guard let gistModel = GistModel(data: data) else {
                self.remoteRequestHandler?.onGistRetrievalFailure(RemoteDataManagerError.parseError)
                return
            }

            self.remoteRequestHandler?.onGistRetrieved(gistModel)
        }, error: { error in
            self.remoteRequestHandler?.onGistRetrievalFailure(error)
        }, failure: { _ in
            let error = RemoteDataManagerError.other(NSError(domain: "Failure onCommentsRetrievalFailure", code: -1,
                                                             userInfo: nil))
            self.remoteRequestHandler?.onGistRetrievalFailure(error)
        })
    }

    func retriveComments(with gistId: GistId) {

        self.request(.comments(gistId: gistId), success: { data in
            guard let comments = try? self.jsonDecoder.decode([GistComment].self, from: data) else {
                self.remoteRequestHandler?.onCommentsRetrievalFailure(RemoteDataManagerError.parseError)
                return
            }

            self.remoteRequestHandler?.onCommentsRetrieved(comments)
        }, error: { error in
            self.remoteRequestHandler?
                .onCommentsRetrievalFailure(error)

        }, failure: { _ in
            let error = RemoteDataManagerError.other(NSError(domain: "Failure onCommentsRetrievalFailure", code: -1,
                                                             userInfo: nil))
            self.remoteRequestHandler?.onCommentsRetrievalFailure(error)
        })
    }
}
