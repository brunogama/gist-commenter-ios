//
//  QRCodeReaderPresenter.swift
//  GistCommenter
//
//  Created Bruno Gama on 21/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import AVFoundation
import UIKit

internal class QRCodeReaderPresenter: QRCodeReaderPresenterProtocol, QRCodeReaderInteractorOutputProtocol {

    weak private var view: QRCodeReaderViewProtocol?
    var interactor: QRCodeReaderInteractorInputProtocol?
    private let router: QRCodeReaderWireframeProtocol

    init(interface: QRCodeReaderViewProtocol,
         interactor: QRCodeReaderInteractorInputProtocol?,
         router: QRCodeReaderWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    // MARK: - QRCodeReaderPresenterProtocol

    func viewDidLoad() {
        interactor?.startReader()
    }

    func newReading() {
        view?.loading()
        interactor?.startReader()
    }

    // MARK: - QRCodeReaderInteractorOutputProtocol

    func didReceived(data: QRCodeReadable.QRCodeData) {
        view?.updateStatus(codeValue: data.value)
        view?.updateViewFinder(area: data.codeBounds)
        if isGistHost(string: data.value) {
            view?.showGistAlert()
        }
        else {
            view?.showInvalidCodeAlert()
        }
    }

    // MARK: - Private methods
    fileprivate func isGistHost(string: String) -> Bool {
        return URLComponents(string: string)?.host == "gist.github.com"
    }
}
