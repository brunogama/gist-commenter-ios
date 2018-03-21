//
//  QRCodeReaderPresenter.swift
//  GistCommenter
//
//  Created Bruno Gama on 21/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

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

}
