//
//  GistDetailInteractor.swift
//  GistCommenter
//
//  Created Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Moya
import UIKit

internal final class GistDetailInteractor: GistDetailInteractorInputProtocol, RemoteDataManagerOutputProtocol {

    weak var presenter: GistDetailInteractorOutputProtocol?
    var remoteDataManager: RemoteDataManagerInputProtocol?

    func retrieveComments(fromGistId: GistId) {
        remoteDataManager?.retriveComments(with: fromGistId)
    }

    func requestGistModel(url: URL) {
    }

    func didReceived(comments: [GistComment]) {
        presenter?.didReceived(comments: comments)
    }

    func onGistRetrieved(_ gist: GistModel) {}
    func onGistRetrievalFailure(_ error: Error) {}

    func onCommentsRetrieved(_ comments: [GistComment]) {
        presenter?.didReceived(comments: comments)
    }

    func onCommentsRetrievalFailure(_ error: Error) {
        Logger.e("\(error)")
    }

}
